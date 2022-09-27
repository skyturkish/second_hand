// TODO bunun serviste olması lazım aslında
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

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

// Future<Iterable<Reference>> getImages(String productId) =>
//     FirebaseStorage.instance.ref('products').child(productId).list().then((listResult) => listResult.items);

// Future<bool> uploadProductPhotoSky({
//   required File file,
//   required String productId,
// }) =>
//     FirebaseStorage.instance
//         .ref('products')
//         .child(productId)
//         .child(const Uuid().v4())
//         .putFile(file)
//         .then((_) => true)
//         .catchError((_) => false);
