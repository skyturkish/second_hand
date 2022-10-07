import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/product/abstract_product_service.dart';
import 'package:second_hand/service/storage/storage-service.dart';
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
      final compressedimage = await compressFile(image);
      await StorageService.instance.uploadProductPhoto(
        file: compressedimage,
        productId: product.productId,
        childUUID: imageId,
      );
      product.imagesPath.add('products/${product.productId}/$imageId');
    }
    await _collection.doc().set(
          product.toMap(),
        );
  }

  // TODO galiba burayı da stream ile yapmak zorundayız :shrug:
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

  // TODO bunu kullacının içindeki ürünlerden aratıp da yapabilirsin bu biraz aşırı kaçıyor
  @override
  Stream<Iterable<Product>> getAllOwnerProductsStream({required String userId}) => _collection
      .snapshots()
      .map((event) => event.docs.map((doc) => Product.fromSnapShot(doc)).where((product) => product.ownerId == userId));

  @override
  Stream<Iterable<Product>> getAllFavoriteProductsStream({required String userId, required BuildContext context}) =>
      _collection
          .where('productId', whereIn: context.watch<UserInformationNotifier>().userInformation.favoriteAds)
          .snapshots()
          .map(
            (event) => event.docs.map(
              Product.fromSnapShot, // same --> (doc) => Product.fromSnapShot(doc)
            ),
          );

  // TODO This don't belong here, to where ?
  Future<File> compressFile(File file) async {
    final compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 50,
    );
    return compressedFile;
  }
}
