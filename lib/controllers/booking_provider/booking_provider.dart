// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_amount.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_availability.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_executor.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/person_count_provider.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/services/booking_services.dart';
import 'package:provider/provider.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService bookingService = BookingService();

  final BookingAvailability availability = BookingAvailability();
  final BookingAmountCalculator amountCalculator = BookingAmountCalculator();
  final BookingExecutor executor = BookingExecutor();

  List<BookingModel>? bookings;
  bool isLoading = false;

  int? get availableRooms => availability.availableRooms;
  int? get totalAmount => amountCalculator.amount;
  bool get isCheckingAvailability => availability.isCheckingAvailability;

  DateTime? get checkInDate => amountCalculator.checkInDate;
  DateTime? get checkOutDate => amountCalculator.checkOutDate;
  int? get requiredRooms => amountCalculator.requiredRooms;

  get adultCount => null;

  get childrenCount => null;

  Future<bool> calculateAmountAndAvailability({
    required String hotelId,
    required String roomId,
    required RoomModel roomData,
    required DateRangeProvider dateRangeProvider,
    required PersonCountProvider personCountProvider,
  }) async {
    final result = await amountCalculator.calculateAmount(
      availability: availability,
      hotelId: hotelId,
      roomId: roomId,
      roomData: roomData,
      dateRangeProvider: dateRangeProvider,
      personCountProvider: personCountProvider,
    );
    notifyListeners();
    return result;
  }

  Future<void> bookRoom({
    required BuildContext context,
    required String hotelId,
    required HotelModel hotelData,
    required RoomModel roomData,
    required String roomId,
  }) async {
    await executor.bookRoom(
      context: context,
      hotelId: hotelId,
      hotelData: hotelData,
      roomData: roomData,
      roomId: roomId,
      amount: totalAmount,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      requiredRooms: requiredRooms,
      adultCount: amountCalculator.adultCount,
      childrenCount: amountCalculator.childrenCount,
      onSuccess: () async {
        availability.clear();
        amountCalculator.clear();
        Provider.of<DateRangeProvider>(listen: false, context).clearDateRange();
        Provider.of<PersonCountProvider>(
          listen: false,
          context,
        ).clearPersonData();
        notifyListeners();
        await fetchBookings();
      },
    );
  }

  Future<void> fetchBookings() async {
    try {
      isLoading = true;
      notifyListeners();
      bookings = await bookingService.fetchUserBookings();
    } catch (e) {
      bookings = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearAvailabilityData() {
    availability.clear();
    amountCalculator.clear();
    notifyListeners();
  }

  Future<bool> cancelBooking({
    required String bookingId,
    required String hotelId,
  }) async {
    try {
      await bookingService.cancelBooking(
        bookingId: bookingId,
        hotelId: hotelId,
      );
      await fetchBookings();
      return true;
    } catch (e) {
      return false;
    }
  }

  void clear() {
    bookings = null;
    isLoading = false;
    availability.clear();
    amountCalculator.clear();
    notifyListeners();
  }
}
