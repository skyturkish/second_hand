import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/product.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

// for images, yes, this must be provider
class ProductNotifier extends ChangeNotifier {
  ProductNotifier();

  List<File> images = [];

  void addImages({required List<File> newImages}) {
    for (var image in newImages) {
      images.add(image);
      notifyListeners();
    }
  }

  void removeImage({required int index}) {
    images.removeAt(index);
    notifyListeners();
  }

  Product product = Product(
    productId: '',
    ownerId: '',
    state: '',
    title: '',
    description: '',
    imagesPath: [],
    price: 1,
  );

  Product get currentProduct => product;

  void clearProduct() {
    product = Product(
      productId: '',
      ownerId: '',
      state: '',
      title: '',
      description: '',
      imagesPath: [],
      price: 1,
    );
    images = [];
  }

  void addimagesPath({
    required String newPath,
  }) {
    product.imagesPath.add(newPath);
  }

  void setProduct({
    String? productId,
    String? ownerId,
    String? state,
    String? title,
    String? description,
    List<String>? images,
    int? price,
  }) {
    product.productId = productId ?? product.productId;
    product.ownerId = ownerId ?? product.ownerId;
    product.state = state ?? product.state;
    product.title = title ?? product.title;
    product.description = description ?? product.description;
    product.imagesPath = images ?? product.imagesPath;
    product.price = price ?? product.price;

    notifyListeners();
  }

  void skytoString() {
    'productId: ${product.productId}, ownerId: ${product.ownerId}, state: ${product.state},title: ${product.title},description: ${product.description},images: ${product.imagesPath},price: ${product.price}'
        .log();
  }
}
