import 'package:json_annotation/json_annotation.dart';
import 'package:second_hand/core/constants/app/app_constants.dart';

part 'user_information.g.dart';

@JsonSerializable()
class UserInformation {
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
  final String profilePhotoPath;
  final String phoneNumber;
  final String aboutYou;
  final List<String> myProducts;
  final List<String> favoriteProducts;
  final List<String> following;
  final List<String> followers;

  factory UserInformation.fromMap(Map<String, dynamic> json) => _$UserInformationFromJson(json);
  Map<String, dynamic> toJson() => _$UserInformationToJson(this);

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
