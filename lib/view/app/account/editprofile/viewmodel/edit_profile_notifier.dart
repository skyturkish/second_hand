import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:second_hand/product/utilities/compress/compress_image.dart';
import 'package:second_hand/services/storage/storage-service.dart';

class EditProfileNotifier extends ChangeNotifier {
  File? userPhoto;
  String? name;
  String? aboutYou;

  void setEditProfileInformations({String? setName, String? setAboutYou, File? image}) {
    userPhoto = image;
    name = setName;
    aboutYou = setAboutYou;
    notifyListeners();
  }

  void clearEditProfileInformations() {
    userPhoto = null;
    name = null;
    aboutYou = null;
  }

  Future<String?> changeFirebasePhotoIfPhotoChange({required String userId}) async {
    if (userPhoto == null) return null;

    final compressedFile = await ImageCompress.instance.compressFile(userPhoto!);

    final taskSnapshot = await StorageService.instance.uploadUserPhoto(file: compressedFile, userId: userId);

    final profilePhotoDownloadURL = await taskSnapshot.ref.getDownloadURL();

    notifyListeners();

    return profilePhotoDownloadURL;
  }

  bool anyChanges({required String newName, required String newAboutYou}) {
    return name != newName || aboutYou != newAboutYou || userPhoto != null;
  }
}
