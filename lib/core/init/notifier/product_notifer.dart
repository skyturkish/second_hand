import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:uuid/uuid.dart';

// bunun adı ürünü sattığını daha fazla belli eden bir şey olmalı
class SaleProductNotifier extends ChangeNotifier {
  SaleProductNotifier();

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

  // If title place is not empty,  the user has not yet completed the process of selling the product.
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
}
