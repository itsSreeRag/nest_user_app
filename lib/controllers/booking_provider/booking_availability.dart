import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/services/booking_services.dart';

class BookingAvailability {
  int? availableRooms;
  bool _isCheckingAvailability = false;

  bool get isCheckingAvailability => _isCheckingAvailability;

  Future<bool> checkAvailability({
    required String hotelId,
    required String roomId,
    required RoomModel roomData,
    required DateTime checkIn,
    required DateTime checkOut,
    required int requiredRooms,
    required BookingService bookingService,
  }) async {
    _isCheckingAvailability = true;
    try {
      availableRooms = await bookingService.checkRoomAvailability(
        hotelId: hotelId,
        roomId: roomId,
        checkInDate: checkIn,
        checkOutDate: checkOut,
        roomData: roomData,
      );
    } catch (e) {
      availableRooms = null;
    } finally {
      _isCheckingAvailability = false;
    }
    return availableRooms != null && availableRooms! >= requiredRooms;
  }

  void clear() {
    availableRooms = null;
    _isCheckingAvailability = false;
  }
}
