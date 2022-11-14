// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInformation _$UserInformationFromJson(Map<String, dynamic> json) =>
    UserInformation(
      userId: json['userId'] as String? ?? 'default user Id',
      name: json['name'] as String? ?? 'defaul',
      profilePhotoPath: json['profilePhotoPath'] as String? ??
          ApplicationConstants.DEFAULT_IMAGE,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      aboutYou: json['aboutYou'] as String? ?? 'Hi I am new here',
      myProducts: (json['myProducts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      favoriteProducts: (json['favoriteProducts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      following: (json['following'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      followers: (json['followers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserInformationToJson(UserInformation instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'profilePhotoPath': instance.profilePhotoPath,
      'phoneNumber': instance.phoneNumber,
      'aboutYou': instance.aboutYou,
      'myProducts': instance.myProducts,
      'favoriteProducts': instance.favoriteProducts,
      'following': instance.following,
      'followers': instance.followers,
    };
