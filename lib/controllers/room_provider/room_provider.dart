// controllers/room_provider/room_provider.dart
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/services/room_firebase_services.dart';

class RoomProvider with ChangeNotifier {
  final RoomService _roomService = RoomService();

  List<RoomModel> _rooms = [];
  List<RoomModel> get rooms => _rooms;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchRoomsForHotel(String hotelUid) async {
    _isLoading = true;
    notifyListeners();

    try {
      _rooms = await _roomService.fetchHotelRooms(hotelUid);
      log("Fetched ${_rooms.length} rooms for hotel: $hotelUid");
    } catch (e) {
      log("Error fetching rooms: $e");
      _rooms = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearRooms() {
    _rooms = [];
    notifyListeners();
  }
}
