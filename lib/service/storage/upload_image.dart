import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

// TODO bunun serviste olması lazım aslında
Future<bool> uploadProductPhoto({
  required File file,
  required String productId,
}) =>
    FirebaseStorage.instance
        .ref('products')
        .child(productId)
        .child(const Uuid().v4())
        .putFile(file)
        .then((_) => true)
        .catchError((_) => false);
