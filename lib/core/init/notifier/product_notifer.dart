import 'dart:developer' as devtools show log;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:uuid/uuid.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

// for images, yes, this must be provider
class ProductNotifier extends ChangeNotifier {
  ProductNotifier();

  List<File> images = [];

  void addImages({required List<File> newImages}) {
    for (final image in newImages) {
      images.add(image);
      notifyListeners();
    }
  }

  void removeImage({required int index}) {
    images.removeAt(index);
    notifyListeners();
  }

  Product get localProduct => product;

  Product product = Product(
    productId: const Uuid().v4(),
    ownerId: '',
    state: '',
    title: '',
    description: '',
    imagesPath: [],
    price: 1,
  );

  void updateProduct({
    String? productId,
    String? ownerId,
    String? state,
    String? title,
    String? description,
    List<String>? imagesPath,
    int? price,
    String? documentId,
  }) {
    product = Product(
      productId: productId ?? product.productId,
      ownerId: ownerId ?? product.ownerId,
      state: state ?? product.state,
      title: title ?? product.title,
      description: description ?? product.description,
      imagesPath: imagesPath ?? product.imagesPath,
      price: price ?? product.price,
      documentId: documentId ?? product.documentId,
    );
  }

  void clearProduct() {
    product = Product(
      productId: const Uuid().v4(),
      ownerId: '',
      state: '',
      title: '',
      description: '',
      imagesPath: [],
      price: 1,
    );
    images = [];
  }

  bool productInProcess() {
    return product.title.isNotEmpty;
  }

  Future<void> releaseProduct() async {
    await ProductCloudFireStoreService.instance.createProduct(
      product: product,
      images: images,
    );

    clearProduct();
  }

  void skytoString() {
    'productId: ${product.productId}, ownerId: ${product.ownerId}, state: ${product.state},title: ${product.title},description: ${product.description},images: ${product.imagesPath},price: ${product.price}'
        .log();
  }
}
