import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';
import 'package:second_hand/service/storage/storage-service.dart';

class UserInformationNotifier extends ChangeNotifier {
  UserInformation get userInformation => _userInformation;

  File? userPhoto;

  UserInformation _userInformation = UserInformation(
    userId: '',
    name: '',
  );

  void resetChanges() {
    userPhoto = null;
  }

  void changeProfilePhotoLocal({required File? image}) {
    userPhoto = image;
    notifyListeners();
  }

  Future<void> saveProfilePhotoToFirebaseIfPhotoChange({required BuildContext context}) async {
    if (userPhoto == null) return;

    final compressedFile = await ProductCloudFireStoreService.instance.compressFile(userPhoto!);

    final taskSnapshot = await StorageService.instance.uploadUserPhoto(
      file: compressedFile,
      userId: AuthService.firebase().currentUser!.id,
    );

    final profilePhotoDownloadURL = await taskSnapshot.ref.getDownloadURL();

    _userInformation.profilePhotoPath = profilePhotoDownloadURL;

    UserCloudFireStoreService.instance.updateUserProfilePhotoPath(
        userId: AuthService.firebase().currentUser!.id, profilePhotoURL: profilePhotoDownloadURL);

    context.read<UserInformationNotifier>()._userInformation.profilePhotoPath = profilePhotoDownloadURL;
  }

  Future<void> getUserInformation({required String userId}) async {
    // çok uzattın aga o ismi
    final userInformationFromFirebase = await UserCloudFireStoreService.instance.getUserInformationById(userId: userId);
    _userInformation = userInformationFromFirebase!;
    _userInformation.favoriteAds.add('value'); // we added this because, when list is empty flutter throw crash ??

    notifyListeners();
  }

  Future<void> addFavoriteProduct({required String productId}) async {
    _userInformation.favoriteAds.add(productId);
    notifyListeners();
    await UserCloudFireStoreService.instance.addProductToFavorites(
      userId: _userInformation.userId,
      productId: productId,
    );
  }

  Future<void> removeFavoriteProduct({required String productId}) async {
    _userInformation.favoriteAds.remove(productId);
    notifyListeners();
    await UserCloudFireStoreService.instance.removeProductToFavorites(
      userId: _userInformation.userId,
      productId: productId,
    );
  }

  bool anyChanges({required String name, required String aboutYou}) {
    return name != _userInformation.name || aboutYou != _userInformation.aboutYou;
  }

  Future<void> changeUserInformationLocal({required String name, required String aboutYou}) async {
    if (!anyChanges(name: name, aboutYou: aboutYou)) return;
    _userInformation
      ..name = name
      ..aboutYou = aboutYou;
    notifyListeners();
  }

  Future<void> changeProfilePhotoPathFirebase({required String profilePhotoURL}) async {
    await UserCloudFireStoreService.instance.updateUserProfilePhotoPath(
      userId: _userInformation.userId,
      profilePhotoURL: profilePhotoURL,
    );
  }

  void clearUserInformations() {
    _userInformation = UserInformation(
      userId: '',
      name: '',
    );
  }
}
