// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/services/booking_services.dart';
import 'package:nest_user_app/services/booking_stripe_services.dart';
import 'package:nest_user_app/views/room_details/booking_amount_page/success_screen.dart';

class BookingExecutor {
  final BookingService _bookingService = BookingService();
  final PaymentHandler _paymentHandler = PaymentHandler();

  Future<void> bookRoom({
    required BuildContext context,
    required String hotelId,
    required HotelModel hotelData,
    required RoomModel roomData,
    required String roomId,
    required int? amount,
    required DateTime? checkInDate,
    required DateTime? checkOutDate,
    required int? requiredRooms,
    required int? adultCount,
    required int? childrenCount,
    required VoidCallback onSuccess,
  }) async {
    if ([amount, checkInDate, checkOutDate, requiredRooms].contains(null)) {
      _showError(context, "Missing booking data.");
      return;
    }

    final isPossible = await _bookingService.isBookingPossible(
      hotelId: hotelId,
      roomId: roomId,
      checkInDate: checkInDate!,
      checkOutDate: checkOutDate!,
      roomData: roomData,
      requestedRooms: requiredRooms!,
    );

    if (!isPossible) {
      _showError(context, "Requested rooms are not available.");
      return;
    }

    final success = await _paymentHandler.processPayment(
      context: context,
      amount: amount!,
    );

    if (!success) return;

    final bookingId = await _bookingService.generateBookingId();
    final userId = _bookingService.currentUserId;

    final booking = BookingModel(
      numberOfRoomsBooked: requiredRooms,
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
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
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

    onSuccess();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SuccessScreen()),
    );
  }

  void _showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
