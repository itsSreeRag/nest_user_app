class BookingModel {
  final String bookingId;
  final String userId;
  final String hotelId;
  final String hotelName;
  final String hotelAddress;
  final String hotelContact;
  final String roomId;
  final String roomName;
  final String roomType;
  final String bedType;
  final String checkInTime;
  final String checkOutTime;

  final DateTime bookingDate;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String adults;
  final String children;
  final String pricePerNight;
  final String totalAmount;
  final String paymentStatus;
  final String paymentMethod;
  final String bookingStatus;

  BookingModel({
    required this.bookingId,
    required this.userId,
    required this.hotelId,
    required this.hotelName,
    required this.hotelAddress,
    required this.hotelContact,
    required this.roomId,
    required this.roomName,
    required this.roomType,
    required this.bedType,
    required this.checkInTime,
    required this.checkOutTime,
    required this.bookingDate,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.pricePerNight,
    required this.totalAmount,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.bookingStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'userId': userId,
      'hotelId': hotelId,
      'hotelName': hotelName,
      'hotelAddress': hotelAddress,
      'hotelContact': hotelContact,
      'roomId': roomId,
      'roomName': roomName,
      'roomType': roomType,
      'bedType': bedType,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'bookingDate': bookingDate.toIso8601String(),
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'adults': adults,
      'children': children,
      'pricePerNight': pricePerNight,
      'totalAmount': totalAmount,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'bookingStatus': bookingStatus,
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'],
      userId: json['userId'],
      hotelId: json['hotelId'],
      hotelName: json['hotelName'],
      hotelAddress: json['hotelAddress'],
      hotelContact: json['hotelContact'],
      roomId: json['roomId'],
      roomName: json['roomName'],
      roomType: json['roomType'],
      bedType: json['bedType'],
      checkInTime: json['checkInTime'],
      checkOutTime: json['checkOutTime'],
      bookingDate: DateTime.parse(json['bookingDate']),
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
      adults: json['adults'],
      children: json['children'],
      pricePerNight: json['pricePerNight'],
      totalAmount: json['totalAmount'],
      paymentStatus: json['paymentStatus'],
      paymentMethod: json['paymentMethod'],
      bookingStatus: json['bookingStatus'],
    );
  }
}
