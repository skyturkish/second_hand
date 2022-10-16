// ignore_for_file: file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/services/cloud/product/abstract_product_service.dart';
import 'package:second_hand/services/storage/storage-service.dart';
import 'package:second_hand/product/utilities/compress/compress_image.dart';
import 'package:uuid/uuid.dart';

class ProductCloudFireStoreService implements IProductCloudFireStoreService {
  ProductCloudFireStoreService._init();

  static ProductCloudFireStoreService get instance {
    _instance ??= ProductCloudFireStoreService._init();
    return _instance!;
  }

  static ProductCloudFireStoreService? _instance;

  final _collection = FirebaseFirestore.instance.collection('products');

  @override
  Future<void> createProduct({required Product product, required List<File> images}) async {
    for (final image in images) {
      final imageId = const Uuid().v4();

      final compressedimage = await ImageCompress.instance.compressFile(image);

      final taskSnapShot = await StorageService.instance.uploadProductPhoto(
        file: compressedimage,
        productId: product.productId,
        childUUID: imageId,
      );

      final downloadURL = await taskSnapShot.ref.getDownloadURL();

      product.imagesPath.add(downloadURL);
    }
    await _collection.doc().set(
          product.toMap(),
        );
  }

  @override
  Future<List<Product>?> getAllBelongProducts({required String userId}) async {
    final querySnapShot = await _collection.where('ownerId', isEqualTo: userId).get();
    final products = querySnapShot.docs.map(
      (queryDocumentSnapshot) => Product.fromMap(
        queryDocumentSnapshot.data(),
      ),
    );
    return products.toList();
  }

  @override
  Future<List<Product>?> getAllNotBelongProducts({required String userId}) async {
    final querySnapShot = await _collection.where('ownerId', isNotEqualTo: userId).get();
    final products = querySnapShot.docs.map(
      (queryDocumentSnapshot) => Product.fromMap(
        queryDocumentSnapshot.data(),
      ),
    );
    return products.toList();
  }

  @override
  Future<void> removeProduct({required String productId}) async {
    final querySnapShot = await _collection.where('productId', isEqualTo: productId).get();

    for (final doc in querySnapShot.docs) {
      await doc.reference.delete();
      final data = Product.fromMap(doc.data());

      for (final image in data.imagesPath) {
        StorageService.instance.deleteProductPhoto(
          path: image,
        );
      }
    }
  }

  @override
  Future<void> removeAllProductWithImages({required String userId}) async {
    final querySnapShot = await _collection.where('ownerId', isEqualTo: userId).get();

    for (final doc in querySnapShot.docs) {
      await doc.reference.delete();
      final data = Product.fromMap(doc.data());

      for (final image in data.imagesPath) {
        StorageService.instance.deleteProductPhoto(
          path: image,
        );
      }
    }
  }

  Future<Product> getProductById({required String productId}) async {
    final querySnapShot = await _collection.where('productId', isEqualTo: productId).get();
    return Product.fromSnapShot(querySnapShot.docs.first);
  }

  @override
  Stream<Iterable<Product>> getAllOwnerProductsStream({required String userId}) => _collection
      .snapshots()
      .map((event) => event.docs.map((doc) => Product.fromSnapShot(doc)).where((product) => product.ownerId == userId));

  @override
  Stream<Iterable<Product>> getAllFavoriteProductsStream({required String userId, required BuildContext context}) =>
      _collection
          .where('productId', whereIn: context.watch<UserInformationNotifier>().userInformation.favoriteProducts)
          .snapshots()
          .map(
            (event) => event.docs.map(
              Product.fromSnapShot, // same --> (doc) => Product.fromSnapShot(doc)
            ),
          );
}
