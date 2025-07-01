class ReviewRatingModel {
  final double ratings;
  final String review;
  final String userId;
  final String hotelId;
  final String reviewTitle;
  final String publicName;
  final String reviewId;
  final DateTime createdAt;

  ReviewRatingModel({
    required this.ratings,
    required this.review,
    required this.userId,
    required this.hotelId,
    required this.reviewTitle,
    required this.publicName,
    required this.reviewId,
     required this.createdAt
  });

  Map<String, dynamic> toJson() {
    return {
      'ratings': ratings,
      'review': review,
      'userId': userId,
      'hotelId': hotelId,
      'reviewTitle': reviewTitle,
      'publicName': publicName,
      'reviewId': reviewId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReviewRatingModel.fromJson(Map<String, dynamic> json) {
    return ReviewRatingModel(
      ratings: (json['ratings'] as num).toDouble(),
      review: json['review'] ?? '',
      userId: json['userId'] ?? '',
      hotelId: json['hotelId'] ?? '',
      reviewTitle: json['reviewTitle'] ?? '',
      publicName: json['publicName'] ?? '',
      reviewId: json['reviewId'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
