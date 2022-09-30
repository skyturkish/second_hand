class UserInformation {
  final String userId;
  final String name;
  String? profilePhotoPath;
  String? phoneNumber;
  String? aboutYou;
  final List<String> myAds;
  final List<String> favoriteAds;
  // following
  // follower
  UserInformation({
    required this.userId,
    required this.name,
    this.profilePhotoPath = '',
    this.phoneNumber = '',
    this.aboutYou = '',
    this.myAds = const [],
    this.favoriteAds = const [],
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'name': name});
    if (profilePhotoPath != null) {
      result.addAll({'profilePhotoPath': profilePhotoPath});
    }
    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (aboutYou != null) {
      result.addAll({'aboutYou': aboutYou});
    }
    result.addAll({'myAds': myAds});
    result.addAll({'favoriteAds': favoriteAds});

    return result;
  }

  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      profilePhotoPath: map['profilePhotoPath'],
      phoneNumber: map['phoneNumber'],
      aboutYou: map['aboutYou'],
      myAds: List<String>.from(map['myAds']),
      favoriteAds: List<String>.from(map['favoriteAds']),
    );
  }
}
