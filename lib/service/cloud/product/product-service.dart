import 'package:firebase_storage/firebase_storage.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/base-service.dart';
import 'package:second_hand/service/storage/upload_image.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class GroupCloudFireStoreService extends CloudFireStoreBaseService {
  static GroupCloudFireStoreService get instance {
    _instance ??= GroupCloudFireStoreService._init(collectionName: 'products');
    return _instance!;
  }

  GroupCloudFireStoreService._init({required super.collectionName});

  static GroupCloudFireStoreService? _instance;

  Future<void> createProduct({required Product product}) async {
    await collection.doc().set(
          product.toMap(),
        );

    for (var image in product.images) {
      await uploadProductPhoto(
        file: image,
        productId: product.productId,
      );
    }
  }

  Future<List<Product>?> getAllProducts() async {
    final storageRef = FirebaseStorage.instance.ref('products');

    final documents = await collection.get();
    final productsWithOutImages = documents.docs.map(
      (product) => Product.fromFirestore(
        product,
        null,
      ),
    );

    for (var product in productsWithOutImages) {
      final ref = FirebaseStorage.instance.ref('products').child(product.productId);
      final listResult = await ref.listAll();
      for (var prefix in listResult.prefixes) {
        prefix.fullPath.log();
      }
    }
    return null;
  }
}
