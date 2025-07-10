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

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  final BookingAvailability _availability = BookingAvailability();
  final BookingAmountCalculator _amountCalculator = BookingAmountCalculator();
  final BookingExecutor _executor = BookingExecutor();

  List<BookingModel>? bookings ;
  bool _isLoading = false;

  // List<BookingModel>? get bookings => _bookings;
  bool get isLoading => _isLoading;

  int? get availableRooms => _availability.availableRooms;
  int? get totalAmount => _amountCalculator.amount;
  bool get isCheckingAvailability => _availability.isCheckingAvailability;

  DateTime? get checkInDate => _amountCalculator.checkInDate;
  DateTime? get checkOutDate => _amountCalculator.checkOutDate;
  int? get requiredRooms => _amountCalculator.requiredRooms;

  get adultCount => null;

  get childrenCount => null;

  Future<bool> calculateAmountAndAvailability({
    required String hotelId,
    required String roomId,
    required RoomModel roomData,
    required DateRangeProvider dateRangeProvider,
    required PersonCountProvider personCountProvider,
  }) async {
    final result = await _amountCalculator.calculateAmount(
      availability: _availability,
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
    await _executor.bookRoom(
      context: context,
      hotelId: hotelId,
      hotelData: hotelData,
      roomData: roomData,
      roomId: roomId,
      amount: totalAmount,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      requiredRooms: requiredRooms,
      adultCount: _amountCalculator.adultCount,
      childrenCount: _amountCalculator.childrenCount,
      onSuccess: () async {
        _availability.clear();
        _amountCalculator.clear();
        notifyListeners();
        await fetchBookings();
      },
    );
  }

  Future<void> fetchBookings() async {
    try {
      _isLoading = true;
      notifyListeners();
      bookings = await _bookingService.fetchUserBookings();
    } catch (e) {
      bookings = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearAvailabilityData() {
    _availability.clear();
    _amountCalculator.clear();
    notifyListeners();
  }

  Future<bool> cancelBooking({
    required String bookingId,
    required String hotelId,
  }) async {
    try {
      await _bookingService.cancelBooking(
        bookingId: bookingId,
        hotelId: hotelId,
      );
      await fetchBookings();
      return true; // indicate success
    } catch (e) {
      return false; // indicate failure
    }
  }
}
