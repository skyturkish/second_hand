// ignore_for_file: file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/string/string_extension.dart';
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
    List<String> newUrls = [];
    final productId = const Uuid().v4();
    for (final image in images) {
      final imageId = const Uuid().v4();

      final compressedimage = await ImageCompress.instance.compressFile(image);

      final taskSnapShot = await StorageService.instance.uploadProductPhoto(
        file: compressedimage,
        productId: product.productId,
        childUUID: imageId,
      );

      final downloadURL = await taskSnapShot.ref.getDownloadURL();

      newUrls.add(downloadURL);
    }

    final sendProduct = product.copyWith(
      imagesUrl: newUrls,
      productId: productId,
    );

    await _collection.doc(productId).set(
          sendProduct.toMap(),
        );
  }

  @override
  Future<List<Product>?> getAllBelongProducts({required String userId}) async {
    final querySnapShot =
        await _collection.where('ownerId', isEqualTo: userId).where('productSellState', isNotEqualTo: 'Removed').get();
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
    return products.where((element) => element.productSellState != 'Removed').toList();
  }

  Future<void> setProductAsRemoved({required Product product}) async {
    await _collection.doc(product.productId).update({'productSellState': 'Removed'});
  }

  @override
  Future<void> removeProduct({required Product product}) async {
    for (final image in product.imagesUrl) {
      await StorageService.instance.deletePhotoByReference(
        path: image.convertToStorageReferenceFromDownloadUrl,
      );
    }
    await _collection.doc(product.productId).delete();
  }

  @override
  Future<void> removeAllProductsById({required String userId}) async {
    final allProducts = await getAllBelongProducts(userId: userId);
    if (allProducts == null) return;
    for (final product in allProducts) {
      removeProduct(product: product);
    }
  }

  @override
  Future<Product> getProductById({required String productId}) async {
    final querySnapShot = await _collection.where('productId', isEqualTo: productId).get();
    return Product.fromSnapShot(querySnapShot.docs.first);
  }

  @override
  Stream<Iterable<Product>> getAllOwnerProductsStream({required String userId}) =>
      _collection.snapshots().map((event) => event.docs
          .map((doc) => Product.fromSnapShot(doc))
          .where((product) => product.ownerId == userId && product.productSellState != 'Removed'));

  @override
  Stream<Iterable<Product>> getAllFavoriteProductsStream({required String userId, required BuildContext context}) {
    List<String> favoriteList = context.watch<UserInformationNotifier>().userInformation!.favoriteProducts;
    if (favoriteList.isEmpty) {
      return const Stream<Iterable<Product>>.empty();
    } else {
      return _collection.where('productId', whereIn: favoriteList).snapshots().map(
            (event) => event.docs.map(
              Product.fromSnapShot, // same --> (doc) => Product.fromSnapShot(doc)
            ),
          );
    }
  }

  @override
  Future<void> updateProductDescription({required String productId, required String newDescription}) async {
    await _collection.doc(productId).update({'description': newDescription});
  }
}
