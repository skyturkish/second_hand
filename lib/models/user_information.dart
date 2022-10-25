import 'package:second_hand/core/constants/app/app_constants.dart';

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
  UserInformation({
    this.userId = 'default user Id',
    this.name = 'defaul',
    this.profilePhotoPath = ApplicationConstants.DEFAULT_IMAGE,
    this.phoneNumber = '',
    this.aboutYou = 'Hi I am new here',
    this.myProducts = const [],
    this.favoriteProducts = const [],
    this.following = const [],
    this.followers = const [],
  });
  final String userId;
  final String name;
  final String profilePhotoPath; // path değilde URL olması lazım bunun, direkt internetten çekiyoruz çünkü
  final String phoneNumber;
  final String aboutYou;
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

  UserInformation copyWith({
    String? userId,
    String? name,
    String? profilePhotoPath,
    String? phoneNumber,
    String? aboutYou,
    List<String>? myProducts,
    List<String>? favoriteProducts,
    List<String>? following,
    List<String>? followers,
  }) {
    return UserInformation(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      aboutYou: aboutYou ?? this.aboutYou,
      myProducts: myProducts ?? this.myProducts,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}
