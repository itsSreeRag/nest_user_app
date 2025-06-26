class HotelModel {
  // Identity & Status
  final String uid;
  final String profileImage;
  final String profileId;
  final String verificationStatus;

  // Contact Info
  final String contactNumber;
  final String email;

  // Location
  final String city;
  final String state;
  final String country;
  final String pincode;

  // Property Details
  final String stayName;
  final String basePrice;
  final String hotelDescription;
  final String accommodationType;
  final String propertyType;
  final bool entireProperty;
  final bool privateProperty;
  final bool restaurantInsideProperty;
  final bool parking;

  // Business Details
  final String hasRegistration;
  final String panNumber;
  final String propertyNumber;
  final String gstNumber;

  // Preferences
  final String? selectedYear;
  final bool freeCancellation;
  final bool coupleFriendly;

  // Images
  final List<String> images;

  HotelModel({
    // Identity
    required this.uid,
    required this.profileImage,
    required this.profileId,
    required this.verificationStatus,

    // Contact Info
    required this.contactNumber,
    required this.email,

    // Location
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,

    // Property Details
    required this.stayName,
    required this.basePrice,
    required this.hotelDescription,
    required this.accommodationType,
    required this.propertyType,
    required this.entireProperty,
    required this.privateProperty,
    required this.restaurantInsideProperty,
    required this.parking,

    // Business Details
    required this.hasRegistration,
    required this.panNumber,
    required this.propertyNumber,
    required this.gstNumber,

    // Preferences
    required this.selectedYear,
    required this.freeCancellation,
    required this.coupleFriendly,

    // Images
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'profileImage': profileImage,
      'profileId': profileId,
      'verificationStatus': verificationStatus,
      'contactNumber': contactNumber,
      'email': email,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'stayName': stayName,
      'basePrice': basePrice,
      'hotelDescription': hotelDescription,
      'accommodationType': accommodationType,
      'propertyType': propertyType,
      'entireProperty': entireProperty,
      'privateProperty': privateProperty,
      'restaurantInsideProperty': restaurantInsideProperty,
      'parking': parking,
      'hasRegistration': hasRegistration,
      'panNumber': panNumber,
      'propertyNumber': propertyNumber,
      'gstNumber': gstNumber,
      'selectedYear': selectedYear,
      'freeCancellation': freeCancellation,
      'coupleFriendly': coupleFriendly,
      'images': images,
    };
  }

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      uid: json['uid'],
      profileImage: json['profileImage'],
      profileId: json['profileId'],
      verificationStatus: json['verificationStatus'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
      stayName: json['stayName'],
      basePrice: json['basePrice'],
      hotelDescription: json['hotelDescription'],
      accommodationType: json['accommodationType'],
      propertyType: json['propertyType'],
      entireProperty: json['entireProperty'],
      privateProperty: json['privateProperty'],
      restaurantInsideProperty: json['restaurantInsideProperty'],
      parking: json['parking'],
      hasRegistration: json['hasRegistration'],
      panNumber: json['panNumber'],
      propertyNumber: json['propertyNumber'],
      gstNumber: json['gstNumber'],
      selectedYear: json['selectedYear'],
      freeCancellation: json['freeCancellation'],
      coupleFriendly: json['coupleFriendly'],
      images: List<String>.from(json['images'] ?? []),
    );
  }
}
