import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
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
      File compressedimage = await compressFile(image);
      await StorageService.instance.uploadProductPhoto(
        file: compressedimage,
        productId: product.productId,
        childUUID: imageId,
      );
      product.imagesPath.add('products/${product.productId}/$imageId');
    }
    await collection.doc().set(
          product.toMap(),
        );
  }

  // TODO galiba burayı da stream ile yapmak zorundayız :shrug:
  Future<List<Product>?> getAllProducts({required String userId}) async {
    final querySnapShot = await collection.where('ownerId', isNotEqualTo: userId).get();
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
        StorageService.instance.deleteProductPhoto(
          path: image,
        );
      }
    }
  }

  Future<void> removeAllProductWithImages({required String userId}) async {
    final querySnapShot = await collection.where('ownerId', isEqualTo: userId).get();

    for (var doc in querySnapShot.docs) {
      await doc.reference.delete();
      final data = Product.fromMap(doc.data());

      for (var image in data.imagesPath) {
        StorageService.instance.deleteProductPhoto(
          path: image,
        );
      }
    }
  }

  // TODO bunu kullacının içindeki ürünlerden aratıp da yapabilirsin bu biraz aşırı kaçıyor
  Stream<Iterable<Product>> getAllOwnerProductsStream({required String userId}) => collection
      .snapshots()
      .map((event) => event.docs.map((doc) => Product.fromSnapShot(doc)).where((product) => product.ownerId == userId));

  Stream<Iterable<Product>> getAllFavoriteProductsStream({required String userId, required BuildContext context}) =>
      collection
          .where('productId', whereIn: context.watch<UserInformationNotifier>().userInformation.favoriteAds)
          .snapshots()
          .map(
            (event) => event.docs.map(
              (doc) => Product.fromSnapShot(doc),
            ),
          );
  // // Ya kullanıcının içinden ürünlere gideceksin ya da bir alltaki gibi kullanıcının bilgilerinden ürünlere gideceksin acaba hangisi daha iyi ?
  // Future<List<Product>?> getAllOwnerProducts({required String ownerId}) async {
  //   final querySnapShot = await collection.where('ownerId', isEqualTo: ownerId).get();
  //   final products = querySnapShot.docs.map(
  //     (queryDocumentSnapshot) => Product.fromMap(
  //       queryDocumentSnapshot.data(),
  //     ),
  //   );
  //   return products.toList();
  // }

// burayi gider ayak bozdun haberin olsun
//   Future<List<Product>?> getAllFavoriteProducts({required String userId}) async {
//     final user = await UserCloudFireStoreService.instance.getUserInformationById(userId: userId);
//     if (user == null) return null;
//     final querySnapShot = await collection.where('productId', isEqualTo: [...user.favoriteAds]).get();
//     final products = querySnapShot.docs.map(
//       (queryDocumentSnapshot) => Product.fromMap(
//         queryDocumentSnapshot.data(),
//       ),
//     );
//     return products.toList();
//   }
// }

// pat yine file.path yazıyormuşuz bunu da kullanabilirim belki
// Future<File> testCompressAndGetFile(File file, String targetPath) async {
//   var result = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path,
//     targetPath,
//     quality: 88,
//     rotate: 180,
//   );

//   print(file.lengthSync());
//   print(result!.lengthSync());

//   return result;
// }

// TODO bu buraya ait değil
  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 50,
    );
    return compressedFile;
  }
}
