import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._privateConstructor();

  static final StorageService _instance = StorageService._privateConstructor();

  static StorageService get instance => _instance;

  Future<TaskSnapshot> uploadProductPhoto({
    required File file,
    required String productId,
    required String childUUID,
  }) async {
    return await FirebaseStorage.instance.ref('products').child(productId).child(childUUID).putFile(file);
  }

  Future<TaskSnapshot> uploadUserPhoto({
    required File file,
    required String userId,
  }) async {
    return await FirebaseStorage.instance.ref('users').child(userId).putFile(file);
  }

  Future<void> deleteProductPhoto({required String path}) =>
      FirebaseStorage.instance.ref(path).delete().then((_) => true).catchError((_) => false);

  Future<void> deleteUserProfilePhoto({required String userId}) =>
      FirebaseStorage.instance.ref('users').child(userId).delete().then((value) => true).catchError(
            (_) => false,
          );
}
