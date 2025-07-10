class ReportModel {
  final String reportId;
  final String userId;
  final String hotelId;
  final String userName;
  final String? bookingId;
  final String title;
  final String description;

  final DateTime createdAt;
  final String status;
  ReportModel({
    required this.reportId,
    required this.userId,
    required this.hotelId,
    required this.userName,
    this.bookingId,
    required this.title,
    required this.description,

    required this.createdAt,
    this.status = 'pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'reportId': reportId,
      'userId': userId,
      'hotelId': hotelId,
      'roomId': userName,
      'bookingId': bookingId,
      'title': title,
      'description': description,

      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      reportId: map['reportId'],
      userId: map['userId'],
      hotelId: map['hotelId'],
      userName: map['roomId'],
      bookingId: map['bookingId'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      status: map['status'],
    );
  }
}
