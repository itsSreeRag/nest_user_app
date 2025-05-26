class UserModel {
  final String userId;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? profileImage;

  UserModel({
    required this.userId,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.profileImage,
  });

  // Convert from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      profileImage: json['profileImage'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'profileImage': profileImage,
    };
  }

  UserModel copyWith({
  String? userId,
  String? name,
  String? email,
  String? profileImage,
}) {
  return UserModel(
    userId: userId ?? this.userId,
    name: name ?? this.name,
    email: email ?? this.email,
    profileImage: profileImage ?? this.profileImage,
  );
}
}
