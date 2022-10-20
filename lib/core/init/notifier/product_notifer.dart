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
    condition: '',
    title: '',
    description: '',
    imagesUrl: [],
    price: 1,
  );

  void updateProduct({
    String? productId,
    String? ownerId,
    String? state,
    String? title,
    String? description,
    List<String>? imagesUrl,
    int? price,
    String? documentId,
  }) {
    product = Product(
      productId: productId ?? product.productId,
      ownerId: ownerId ?? product.ownerId,
      condition: state ?? product.condition,
      title: title ?? product.title,
      description: description ?? product.description,
      imagesUrl: imagesUrl ?? product.imagesUrl,
      price: price ?? product.price,
      documentId: documentId ?? product.documentId,
    );
  }

  void clearProduct() {
    product = Product(
      productId: const Uuid().v4(),
      ownerId: '',
      condition: '',
      title: '',
      description: '',
      imagesUrl: [],
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
