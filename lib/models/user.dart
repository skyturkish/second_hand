import 'dart:convert';

class UserInformation {
  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      profilePhotoPath: map['profilePhotoPath'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      aboutYou: map['aboutYou'] ?? '',
      myAds: List<String>.from(map['myAds']),
      favoriteAds: List<String>.from(map['favoriteAds']),
    );
  }
  // following
  // follower
  UserInformation({
    required this.userId,
    required this.name,
    this.profilePhotoPath = '',
    this.phoneNumber = '',
    this.aboutYou = 'Hi I am new here',
    this.myAds = const [],
    this.favoriteAds = const [],
  });
  final String userId;
  String name;
  String profilePhotoPath;
  String phoneNumber;
  String aboutYou;
  final List<String> myAds;
  final List<String> favoriteAds;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
      ..addAll({'userId': userId})
      ..addAll({'name': name})
      ..addAll({'profilePhotoPath': profilePhotoPath})
      ..addAll({'phoneNumber': phoneNumber})
      ..addAll({'aboutYou': aboutYou})
      ..addAll({'myAds': myAds})
      ..addAll({'favoriteAds': favoriteAds});

    return result;
  }

  String toJson() => json.encode(toMap());
}
