import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get currentUserId => _auth.currentUser!.uid;

  Future<void> addFavorite(String hotelId) async {
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('favorites')
        .doc(hotelId)
        .set({'hotelId': hotelId});
  }

  Future<void> removeFavorite(String hotelId) async {
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('favorites')
        .doc(hotelId)
        .delete();
  }

  Future<List<String>> getFavoriteHotelIds() async {
    final snapshot =
        await _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('favorites')
            .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  Future<bool> isFavorite(String userId, String hotelId) async {
    final doc =
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .doc(hotelId)
            .get();

    return doc.exists;
  }
}
