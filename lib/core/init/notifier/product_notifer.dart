import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/product.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class ProductNotifier extends ChangeNotifier {
  static ProductNotifier? _instance;

  static ProductNotifier get instance {
    _instance ??= ProductNotifier._init();
    return _instance!;
  }

  ProductNotifier._init();

  final Product product = Product(
    productId: '',
    ownerId: '',
    state: '',
    title: '',
    description: '',
    images: [],
    price: 0,
  );

  Product get currentProduct => product;

  void addimages({
    required List<File> newImages,
  }) {
    for (var newImage in newImages) {
      product.images.add(newImage);
    }
    notifyListeners();
  }

  void setProduct({
    String? productId,
    String? ownerId,
    String? state,
    String? title,
    String? description,
    List<File>? images,
    int? price,
  }) {
    product.productId = productId ?? product.productId;
    product.ownerId = ownerId ?? product.ownerId;
    product.state = state ?? product.state;
    product.title = title ?? product.title;
    product.description = description ?? product.description;
    product.images = images ?? product.images;
    product.price = price ?? product.price;

    notifyListeners();
  }

  void skytoString() {
    'productId: ${product.productId}, ownerId: ${product.ownerId}, state: ${product.state},title: ${product.title},description: ${product.description},images: ${product.images},price: ${product.price}'
        .log();
  }
}
