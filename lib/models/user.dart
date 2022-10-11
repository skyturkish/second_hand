import 'dart:convert';

class UserInformation {
  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      profilePhotoPath: map['profilePhotoPath'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      aboutYou: map['aboutYou'] ?? '',
      myProducts: List<String>.from(map['myProducts']),
      favoriteProducts: List<String>.from(map['favoriteProducts']),
      following: List<String>.from(map['following']),
      followers: List<String>.from(map['followers']),
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
    this.myProducts = const [],
    this.favoriteProducts = const [],
    this.following = const [],
    this.followers = const [],
  });
  final String userId;
  String name;
  String profilePhotoPath;
  String phoneNumber;
  String aboutYou;
  final List<String> myProducts;
  final List<String> favoriteProducts;
  final List<String> following;
  final List<String> followers;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
      ..addAll({'userId': userId})
      ..addAll({'name': name})
      ..addAll({'profilePhotoPath': profilePhotoPath})
      ..addAll({'phoneNumber': phoneNumber})
      ..addAll({'aboutYou': aboutYou})
      ..addAll({'myProducts': myProducts})
      ..addAll({'favoriteProducts': favoriteProducts})
      ..addAll({'following': following})
      ..addAll({'followers': followers});

    return result;
  }

  String toJson() => json.encode(toMap());
}
