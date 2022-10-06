import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';
import 'package:second_hand/service/storage/upload_image.dart';

class UserInformationNotifier extends ChangeNotifier {
  UserInformation get userInformation => _userInformation;

  Uint8List? userPhoto;

  UserInformation _userInformation = UserInformation(
    userId: '',
    name: '',
  );

  void changeProfilePhoto({required Uint8List? uint8List}) {
    userPhoto = uint8List;
    notifyListeners();
  }

  Future<void> changeProfilePhotoFirebase({required File? file}) async {
    if (file == null) return;

    final compressedFile = await ProductCloudFireStoreService.instance.compressFile(file);

    await StorageService.instance.uploadUserPhoto(
      file: compressedFile,
      userId: AuthService.firebase().currentUser!.id,
    );
  }

  Future<void> getUserInformation({required String userId}) async {
    // çok uzattın aga o ismi
    final userInformationFromFirebase = await UserCloudFireStoreService.instance.getUserInformationById(userId: userId);
    _userInformation = userInformationFromFirebase!;
    _userInformation.favoriteAds.add('value'); // we added this because, when list is empty flutter throw crash ??
    await getUserPhoto(userId: userId);
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

  Future<void> changeUserInformation({required String name, required String aboutYou}) async {
    if (!anyChanges(name: name, aboutYou: aboutYou)) return;
    _userInformation
      ..name = name
      ..aboutYou = aboutYou;
    notifyListeners();
  }

  Future<void> getUserPhoto({required String userId}) async {
    final uint8List = await FirebaseStorage.instance.ref().child('users/$userId').getData();
    if (uint8List == null) return;
    userPhoto = uint8List;
  }
}
