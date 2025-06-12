import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nanoid/async.dart';
import 'package:nest_user_app/models/booking_model.dart';

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
}
