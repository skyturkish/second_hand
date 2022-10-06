import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._privateConstructor();

  static final StorageService _instance = StorageService._privateConstructor();

  static StorageService get instance => _instance;

  Future<bool> uploadProductPhoto({
    required File file,
    required String productId,
    required String childUUID,
  }) =>
      FirebaseStorage.instance
          .ref('products')
          .child(productId)
          .child(childUUID)
          .putFile(file)
          .then((_) => true)
          .catchError((_) => false);

  Future<bool> uploadUserPhoto({
    required File file,
    required String userId,
  }) =>
      FirebaseStorage.instance.ref('users').child(userId).putFile(file).then((_) => true).catchError((_) => false);

  Future<void> deleteProductPhoto({required String path}) =>
      FirebaseStorage.instance.ref(path).delete().then((_) => true).catchError((_) => false);

  Future<void> deleteUserProfilePhoto({required String userId}) =>
      FirebaseStorage.instance.ref('users').child(userId).delete().then((value) => true).catchError(
            (_) => false,
          );
}
