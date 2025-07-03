import 'package:nest_user_app/controllers/booking_provider/booking_availability.dart';
import 'package:nest_user_app/controllers/date_range_provider/date_range_provider.dart';
import 'package:nest_user_app/controllers/date_range_provider/person_count_provider.dart';
import 'package:nest_user_app/models/room_model.dart';
import 'package:nest_user_app/services/booking_services.dart';

class BookingAmountCalculator {
  int? amount;
  int? requiredRooms;
  int? adultCount;
  int? childrenCount;
  DateTime? checkInDate;
  DateTime? checkOutDate;

  Future<bool> calculateAmount({
    required BookingAvailability availability,
    required String hotelId,
    required String roomId,
    required RoomModel roomData,
    required DateRangeProvider dateRangeProvider,
    required PersonCountProvider personCountProvider,
  }) async {
    final range = dateRangeProvider.selectedDateRange;
    if (range == null) return false;

    checkInDate = range.start;
    checkOutDate = range.end;

    final nights = range.end.difference(range.start).inDays;
    if (nights <= 0) return false;

    final maxAdults = int.tryParse(roomData.maxAdults) ?? 1;
    final maxChildren = int.tryParse(roomData.maxChildren) ?? 0;
    adultCount = personCountProvider.adultCount;
    childrenCount = personCountProvider.childrenCount;
    requiredRooms = personCountProvider.calculateRequiredRooms(
      maxAdultsPerRoom: maxAdults,
      maxChildrenPerRoom: maxChildren,
    );

    final bookingService = BookingService();

    final available = await availability.checkAvailability(
      hotelId: hotelId,
      roomId: roomId,
      roomData: roomData,
      checkIn: checkInDate!,
      checkOut: checkOutDate!,
      requiredRooms: requiredRooms!,
      bookingService: bookingService,
    );

    if (!available) {
      amount = null;
      return false;
    }

    final basePrice = int.tryParse(roomData.basePrice) ?? 0;
    amount = nights * basePrice * requiredRooms!;
    return true;
  }

  void clear() {
    amount = null;
    requiredRooms = null;
    adultCount = null;
    childrenCount = null;
    checkInDate = null;
    checkOutDate = null;
  }
}
