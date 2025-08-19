// services/room_firebase_services.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nest_user_app/models/room_model.dart';

class RoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RoomModel>> fetchHotelRooms(String hotelUid) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('hotels')
              .doc(hotelUid)
              .collection('room_data')
              .get();

      final rooms =
          querySnapshot.docs
              .map((doc) => RoomModel.fromJson(doc.data()))
              .toList();

      return rooms;
    } catch (e) {

      return [];
    }
  }
}
