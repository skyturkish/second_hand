import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/product.dart';

class ProductNotifier extends ChangeNotifier {
  static ProductNotifier? _instance;

  static ProductNotifier get instance {
    _instance ??= ProductNotifier._init();
    return _instance!;
  }

  ProductNotifier._init();

  final Product _product = Product(
    productId: '',
    ownerId: '',
    state: '',
    title: '',
    description: '',
    images: null,
    price: 0,
  );

  Product get currentProduct => _product;

  void setProduct({
    String? productId,
    String? ownerId,
    String? state,
    String? title,
    String? description,
    List<File>? images,
    int? price,
  }) {
    _product.productId = productId ?? _product.productId;
    _product.ownerId = ownerId ?? _product.ownerId;
    _product.state = state ?? _product.state;
    _product.title = title ?? _product.title;
    _product.description = description ?? _product.description;
    _product.images = images ?? _product.images;
    _product.price = price ?? _product.price;

    notifyListeners();
  }
}
