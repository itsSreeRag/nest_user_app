import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nest_user_app/models/hotel_models.dart';

class HotelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<HotelModel>> fetchApprovedHotels() async {
    try {
      final querySnapshot = await _firestore.collectionGroup('profile').get();

      final hotels =
          querySnapshot.docs
              .map((doc) => HotelModel.fromJson(doc.data()))
              .where(
                (hotel) => hotel.verificationStatus != 'pending',
              ) // ✅ Filter
              .toList();

      return hotels;
    } catch (e) {
      print("Error fetching hotel data: $e");
      return [];
    }
  }
}
