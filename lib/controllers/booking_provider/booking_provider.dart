import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/person_count_provider.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/services/booking_services.dart';
import 'package:nest_user_app/services/booking_stripe_services.dart';
import 'package:nest_user_app/views/room_details/booking_amount_page/success_screen.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();
  final PaymentHandler _paymentHandler = PaymentHandler();

  // Stores the total booking amount
  int? amount;

  // Selected check-in and check-out dates
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int? requiredRooms;
  int? adultCount;
  int? childrenCount;

  // Room availability data
  int? availableRooms;
  bool _isCheckingAvailability = false;
  bool get isCheckingAvailability => _isCheckingAvailability;

  // Private list of bookings
  List<BookingModel> _bookings = [];

  // Public getter to access bookings
  List<BookingModel> get bookings => _bookings;

  // Loading state to manage UI feedback
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Checks room availability for the selected date range
  Future<bool> checkRoomAvailability({
    required String hotelId,
    required String roomId,
    required RoomModel roomData,
    required DateRangeProvider dateRangeProvider,
    required PersonCountProvider personCountProvider,
  }) async {
    final range = dateRangeProvider.selectedDateRange;

    if (range == null) {
      availableRooms = null;
      notifyListeners();
      return false;
    }

    _isCheckingAvailability = true;
    notifyListeners();

    try {
      // Calculate required rooms
      final maxAdultsPerRoom = int.tryParse(roomData.maxAdults) ?? 1;
      final maxChildrenPerRoom = int.tryParse(roomData.maxChildren) ?? 0;
      final calculatedRequiredRooms = personCountProvider
          .calculateRequiredRooms(
            maxAdultsPerRoom: maxAdultsPerRoom,
            maxChildrenPerRoom: maxChildrenPerRoom,
          );

      // Check availability
      availableRooms = await _bookingService.checkRoomAvailability(
        hotelId: hotelId,
        roomId: roomId,
        checkInDate: range.start,
        checkOutDate: range.end,
        roomData: roomData,
      );

      _isCheckingAvailability = false;
      notifyListeners();

      // Return true if enough rooms are available
      return availableRooms != null &&
          availableRooms! >= calculatedRequiredRooms;
    } catch (e) {
      log('Error checking availability: $e');
      _isCheckingAvailability = false;
      availableRooms = null;
      notifyListeners();
      return false;
    }
  }
  Future<bool> calculateAmount({
    required DateRangeProvider dateRangeProvider,
    required PersonCountProvider personCountProvider,
    required RoomModel roomData,
    required String hotelId,
    required String roomId,
  }) async {
    final range = dateRangeProvider.selectedDateRange;

    if (range == null) {
      amount = null;
      availableRooms = null;
      notifyListeners();
      return false;
    }

    checkInDate = range.start;
    checkOutDate = range.end;

    final nights = range.end.difference(range.start).inDays;

    if (nights <= 0) {
      amount = null;
      availableRooms = null;
      notifyListeners();
      return false;
    }

    // Calculate required rooms based on guest count and room capacity
    final maxAdultsPerRoom = int.tryParse(roomData.maxAdults) ?? 1;
    final maxChildrenPerRoom = int.tryParse(roomData.maxChildren) ?? 0;
    adultCount = personCountProvider.adultCount;
    childrenCount = personCountProvider.childrenCount;
    requiredRooms = personCountProvider.calculateRequiredRooms(
      maxAdultsPerRoom: maxAdultsPerRoom,
      maxChildrenPerRoom: maxChildrenPerRoom,
    );

    // Check room availability before calculating amount
    final isAvailable = await checkRoomAvailability(
      hotelId: hotelId,
      roomId: roomId,
      roomData: roomData,
      dateRangeProvider: dateRangeProvider,
      personCountProvider: personCountProvider,
    );

    if (!isAvailable) {
      amount = null;
      notifyListeners();
      return false;
    }

    // Calculate total amount: nights × base price × number of rooms
    final basePrice = int.tryParse(roomData.basePrice) ?? 0;
    amount = nights * basePrice * requiredRooms!;

    notifyListeners();
    return true;
  }

  /// Handles the room booking process including:
  /// - Availability check
  /// - Payment processing (delegated to PaymentHandler)
  /// - Storing booking data in Firestore
  /// - Navigation to success screen
  Future<void> bookRoom({
    required BuildContext context,
    required String hotelId,
    required HotelModel hotelData,
    required RoomModel roomData,
    required String roomId,
  }) async {
    try {
      if (amount == null ||
          checkInDate == null ||
          checkOutDate == null ||
          requiredRooms == null) {
        log('Error: Missing booking data');
        _showErrorMessage(context, 'Please select a valid date range.');
        return;
      }

      // Final availability check before booking
      final isBookingPossible = await _bookingService.isBookingPossible(
        hotelId: hotelId,
        roomId: roomId,
        checkInDate: checkInDate!,
        checkOutDate: checkOutDate!,
        roomData: roomData,
        requestedRooms: requiredRooms!,
      );

      if (!isBookingPossible) {
        _showErrorMessage(
          context,
          'Sorry, the requested rooms are no longer available for the selected dates.',
        );
        return;
      }

      // Process payment using PaymentHandler
      bool paymentSuccess = await _paymentHandler.processPayment(
        context: context,
        amount: amount!,
      );

      if (!paymentSuccess) {
        log('Payment failed. Booking not stored.');
        return;
      }

      // Payment successful, proceed with booking
      await _createAndStoreBooking(
        context: context,
        hotelId: hotelId,
        hotelData: hotelData,
        roomData: roomData,
        roomId: roomId,
      );
    } catch (e) {
      log('Error during booking: $e');
      _showErrorMessage(context, 'Something went wrong. Please try again.');
    }
  }

  // Creates booking model and stores it in Firestore
  Future<void> _createAndStoreBooking({
    required BuildContext context,
    required String hotelId,
    required HotelModel hotelData,
    required RoomModel roomData,
    required String roomId,
  }) async {
    try {
      final bookingId = await _bookingService.generateBookingId();
      final userId = _bookingService.currentUserId;

      final booking = BookingModel(
        numberOfRoomsBooked: requiredRooms!,
        bookingId: bookingId,
        userId: userId,
        hotelId: hotelId,
        hotelName: hotelData.stayName,
        hotelAddress:
            '${hotelData.city}, ${hotelData.state}, ${hotelData.country}, ${hotelData.pincode}',
        hotelContact: hotelData.contactNumber,
        roomId: roomId,
        roomName: roomData.roomName,
        roomType: roomData.roomType,
        bedType: roomData.bedType,
        checkInTime: roomData.checkInTime,
        checkOutTime: roomData.checkOutTime,
        bookingDate: DateTime.now(),
        checkInDate: checkInDate!,
        checkOutDate: checkOutDate!,
        adults: adultCount.toString(),
        children: childrenCount.toString(),
        pricePerNight: roomData.basePrice,
        totalAmount: amount.toString(),
        paymentStatus: '',
        paymentMethod: 'Stripe',
        bookingStatus: 'Booked',
      );

      await _bookingService.storeBookingInFirestore(
        booking: booking,
        bookingId: bookingId,
      );

      // Reset availability data after successful booking
      availableRooms = null;
      amount = null;

      // Navigate to success screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()),
      );
    } catch (e) {
      log('Error storing booking: $e');
      _showErrorMessage(context, 'Booking failed. Please try again.');
    }
  }

  /// Fetches all bookings for a specific user from Firestore
  Future<void> fetchBookings() async {
    try {
      _isLoading = true;
      notifyListeners();

      _bookings = await _bookingService.fetchUserBookings();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      log('Error fetching bookings: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Helper method to show error messages
  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Clears availability data when dates or guest count changes
  void clearAvailabilityData() {
    availableRooms = null;
    amount = null;
    notifyListeners();
  }
}
