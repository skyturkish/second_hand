import 'dart:io';

import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/base-service.dart';
import 'package:second_hand/service/storage/upload_image.dart';
import 'dart:developer' as devtools show log;

import 'package:uuid/uuid.dart';

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

  Future<void> createProduct({required Product product, required List<File> images}) async {
    for (var image in images) {
      final String imageId = const Uuid().v4();

      await uploadProductPhoto(
        file: image,
        productId: product.productId,
        childUUID: imageId,
      );
      product.imagesPath.add('products/${product.productId}/$imageId');
    }

    await collection.doc().set(
          product.toMap(),
        );
  }

  Future<List<Product>?> getAllProducts() async {
    final querySnapShot = await collection.get();
    final products = querySnapShot.docs.map(
      (queryDocumentSnapshot) => Product.fromMap(
        queryDocumentSnapshot.data(),
      ),
    );
    return products.toList();
  }
}
