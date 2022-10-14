import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';
import 'package:second_hand/service/storage/storage-service.dart';
import 'package:second_hand/utilities/compress/compress_image.dart';

class UserInformationNotifier extends ChangeNotifier {
  UserInformation get userInformation => _userInformation;

  File? userPhoto;

  UserInformation _userInformation = UserInformation(
    userId: '',
    name: '',
  );

  void changeProfilePhotoPathLocal({required String newPhotoPath}) {
    _userInformation.profilePhotoPath = newPhotoPath;
    notifyListeners();
  }

  void clearLocalPhoto() {
    userPhoto = null;
  }

  void changeProfilePhotoLocal({required File? image}) {
    userPhoto = image;
    notifyListeners();
  }

  // notifier neden servisin görevini yapıyor ???
  Future<void> saveProfilePhotoToFirebaseIfPhotoChange({required BuildContext context}) async {
    // check photo is changed or not
    if (userPhoto == null) return;
    // compressed Image help to https://pub.dev/packages/flutter_native_image
    final compressedFile = await ImageCompress.instance.compressFile(userPhoto!);
    // We upload photo to firebase then take download URl to save to local and firebase
    final taskSnapshot = await StorageService.instance.uploadUserPhoto(
      file: compressedFile,
      userId: AuthService.firebase().currentUser!.id,
    );

    final profilePhotoDownloadURL = await taskSnapshot.ref.getDownloadURL();

    // local
    context.read<UserInformationNotifier>().changeProfilePhotoPathLocal(newPhotoPath: profilePhotoDownloadURL);
    // firebase, we don't use await because, we don't have to wait to update, we won't take user information again
    UserCloudFireStoreService.instance.updateUserProfilePhotoPath(
        userId: AuthService.firebase().currentUser!.id, profilePhotoURL: profilePhotoDownloadURL);
  }

  Future<void> getUserInformationById({required String userId}) async {
    final userInformationFromFirebase = await UserCloudFireStoreService.instance.getUserInformationById(userId: userId);
    _userInformation = userInformationFromFirebase!;
    _userInformation.favoriteProducts.add('value'); // we added this because, when list is empty firebase throw crash ?

    notifyListeners();
  }

  // add favorite product to local and firebase
  Future<void> addFavoriteProduct({required String productId}) async {
    _userInformation.favoriteProducts.add(productId);
    notifyListeners();
    await UserCloudFireStoreService.instance.addProductToFavorites(
      userId: _userInformation.userId,
      productId: productId,
    );
  }

  // remove favorite product to local and firebase
  Future<void> removeFavoriteProduct({required String productId}) async {
    _userInformation.favoriteProducts.remove(productId);
    notifyListeners();
    await UserCloudFireStoreService.instance.removeProductToFavorites(
      userId: _userInformation.userId,
      productId: productId,
    );
  }

  // we are checking whether there are any changes to the edit page.
  bool anyChanges({required String name, required String aboutYou}) {
    return !(name == _userInformation.name && aboutYou == _userInformation.aboutYou) || userPhoto != null;
  }

  // change user Information locally
  Future<void> changeUserInformationLocal({required String name, required String aboutYou}) async {
    _userInformation
      ..name = name
      ..aboutYou = aboutYou;
    notifyListeners();
  }

  // clear user Information locally, when logout or delete account
  void clearUserInformationsLocal() {
    _userInformation = UserInformation(
      userId: '',
      name: '',
    );
  }

  // follow user
  Future<void> followUserBothFirebaseAndLocal({
    required String userIdWhichOneWillFollow,
    required String followerId,
  }) async {
    _userInformation.following.add(userIdWhichOneWillFollow);

    notifyListeners();

    await UserCloudFireStoreService.instance.followUser(
      userIdWhichOneWillFollow: userIdWhichOneWillFollow,
      followerId: AuthService.firebase().currentUser!.id,
    );
  } // TODO isimlendirmeleri düzelt

  // break follow user
  Future<void> breakFollowUserBothFirebaseAndLocal({
    required String userIdWhichOneWillFollow,
    required String followerId,
  }) async {
    _userInformation.following.remove(userIdWhichOneWillFollow);

    notifyListeners();

    await UserCloudFireStoreService.instance.breakFollowUser(
      userIdWhichOneWillFollow: userIdWhichOneWillFollow,
      followerId: AuthService.firebase().currentUser!.id,
    );
  }
}
