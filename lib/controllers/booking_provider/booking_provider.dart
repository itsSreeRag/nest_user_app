// booking_provider.dart
// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';
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

  // Private list of bookings
  List<BookingModel> _bookings = [];

  // Public getter to access bookings
  List<BookingModel> get bookings => _bookings;

  // Loading state to manage UI feedback
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Calculates the booking amount based on date range and room price
  Future<void> calculateAmount({
    required DateRangeProvider dateRangeProvider,
    required RoomModel roomData,
  }) async {
    final range = dateRangeProvider.selectedDateRange;

    if (range == null) {
      amount = null;
      notifyListeners(); // Notify UI to update
      return;
    }

    checkInDate = range.start;
    checkOutDate = range.end;

    final nights = range.end.difference(range.start).inDays;

    // If check-out is same or before check-in
    if (nights <= 0) {
      amount = null;
      notifyListeners();
      return;
    }

    // Calculate amount: nights × base price
    amount = nights * int.parse(roomData.basePrice);
    notifyListeners(); // Update listeners after calculating amount
  }

  /// Handles the room booking process including:
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
      if (amount == null || checkInDate == null || checkOutDate == null) {
        log('Error: Missing booking data');
        _showErrorMessage(context, 'Please select a valid date range.');
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

  //Creates booking model and stores it in Firestore
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
        adults: roomData.maxAdults,
        children: roomData.maxChildren,
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
}
