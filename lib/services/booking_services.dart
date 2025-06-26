
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nanoid/async.dart';
import 'package:nest_user_app/models/booking_model.dart';
import 'package:nest_user_app/models/room_model.dart';

class BookingService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> generateBookingId() async {
    return await nanoid(10);
  }

  String get currentUserId => _auth.currentUser!.uid;

  Future<void> storeBookingInFirestore({
    required BookingModel booking,
    required String bookingId,
  }) async {
    final uid = currentUserId;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('bookings')
        .doc(bookingId)
        .set(booking.toJson());

    await _firestore
        .collection('hotels')
        .doc(booking.hotelId)
        .collection('bookings')
        .doc(bookingId)
        .set(booking.toJson());

    log('Booking stored in Firestore.');
  }

  Future<List<BookingModel>> fetchUserBookings() async {
    final uid = currentUserId;

    final snapshot =
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('bookings')
            .orderBy('bookingDate', descending: true)
            .get();

    return snapshot.docs
        .map((doc) => BookingModel.fromJson(doc.data()))
        .toList();
  }

  /// Checks room availability for a specific date range
  /// Returns the number of available rooms for the given room type
  Future<int> checkRoomAvailability({
    required String hotelId,
    required String roomId,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required RoomModel roomData,
  }) async {
    try {
      // Get total number of rooms available for this room type
      final totalRooms = int.tryParse(roomData.numberOfRooms) ?? 0;

      if (totalRooms <= 0) {
        log('No rooms available for room type: ${roomData.roomType}');
        return 0;
      }

      // Fetch all bookings for this hotel and room type that overlap with the requested dates
      final bookingsSnapshot =
          await _firestore
              .collection('hotels')
              .doc(hotelId)
              .collection('bookings')
              .where('roomId', isEqualTo: roomId)
              .where(
                'bookingStatus',
                isEqualTo: 'Booked',
              ) // Only count active bookings
              .get();

      int bookedRooms = 0;

      for (var doc in bookingsSnapshot.docs) {
        final booking = BookingModel.fromJson(doc.data());

        // Check if the booking dates overlap with the requested dates
        if (_datesOverlap(
          checkInDate,
          checkOutDate,
          booking.checkInDate,
          booking.checkOutDate,
        )) {
          bookedRooms += booking.numberOfRoomsBooked;
        }
      }

      final availableRooms = totalRooms - bookedRooms;
      log(
        'Total rooms: $totalRooms, Booked rooms: $bookedRooms, Available rooms: $availableRooms',
      );

      return availableRooms > 0 ? availableRooms : 0;
    } catch (e) {
      log('Error checking room availability: $e');
      return 0;
    }
  }

  /// Helper method to check if two date ranges overlap
  bool _datesOverlap(
    DateTime requestStart,
    DateTime requestEnd,
    DateTime bookingStart,
    DateTime bookingEnd,
  ) {
    // Two date ranges overlap if:
    // - Request start is before booking end AND
    // - Request end is after booking start
    return requestStart.isBefore(bookingEnd) &&
        requestEnd.isAfter(bookingStart);
  }

  /// Checks if sufficient rooms are available for the requested booking
  Future<bool> isBookingPossible({
    required String hotelId,
    required String roomId,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required RoomModel roomData,
    required int requestedRooms,
  }) async {
    final availableRooms = await checkRoomAvailability(
      hotelId: hotelId,
      roomId: roomId,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      roomData: roomData,
    );

    return availableRooms >= requestedRooms;
  }

  /// Gets detailed availability information for a room
  Future<Map<String, dynamic>> getRoomAvailabilityDetails({
    required String hotelId,
    required String roomId,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required RoomModel roomData,
  }) async {
    final totalRooms = int.tryParse(roomData.numberOfRooms) ?? 0;
    final availableRooms = await checkRoomAvailability(
      hotelId: hotelId,
      roomId: roomId,
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      roomData: roomData,
    );

    return {
      'totalRooms': totalRooms,
      'availableRooms': availableRooms,
      'bookedRooms': totalRooms - availableRooms,
      'isAvailable': availableRooms > 0,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
    };
  }
}
