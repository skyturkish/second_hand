import 'dart:io';

import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/base-service/base-service.dart';
import 'package:second_hand/service/storage/upload_image.dart';
import 'package:uuid/uuid.dart';

class ProductCloudFireStoreService extends CloudFireStoreBaseService {
  static ProductCloudFireStoreService get instance {
    _instance ??= ProductCloudFireStoreService._init(collectionName: 'products');
    return _instance!;
  }

  ProductCloudFireStoreService._init({required super.collectionName});

  static ProductCloudFireStoreService? _instance;

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

  Future<List<Product>?> getAllOwnerProducts({required String ownerId}) async {
    final querySnapShot = await collection.where('ownerId', isEqualTo: ownerId).get();
    final products = querySnapShot.docs.map(
      (queryDocumentSnapshot) => Product.fromMap(
        queryDocumentSnapshot.data(),
      ),
    );
    return products.toList();
  }

  Future<void> removeProduct({required String productId}) async {
    final querySnapShot = await collection.where('productId', isEqualTo: productId).get();

    for (var doc in querySnapShot.docs) {
      await doc.reference.delete();
      final data = Product.fromMap(doc.data());

      for (var image in data.imagesPath) {
        deleteProductPhoto(
          path: image,
        );
      }
    }
  }
}
