import 'dart:convert';

class UserInformation {
  final String userId;
  final String name;
  String profilePhotoPath;
  String phoneNumber;
  String aboutYou;
  final List<String> myAds;
  final List<String> favoriteAds;
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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'name': name});
    result.addAll({'profilePhotoPath': profilePhotoPath});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'aboutYou': aboutYou});
    result.addAll({'myAds': myAds});
    result.addAll({'favoriteAds': favoriteAds});

    return result;
  }

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

  String toJson() => json.encode(toMap());

  factory UserInformation.fromJson(String source) => UserInformation.fromMap(json.decode(source));
}
