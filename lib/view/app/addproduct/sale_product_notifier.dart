import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/product/product.dart';

class SaleProductNotifier extends ChangeNotifier {
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

  Product? get localProduct => _product;

  Product? _product;

  void updateProduct({
    String? productId,
    String? ownerId,
    String? condition,
    String? title,
    String? description,
    List<String>? imagesUrl,
    int? price,
    String? productSellState,
    String? locateCountry,
    String? locateCity,
  }) {
    if (_product == null) {
      _product = Product(
        productId: '',
        ownerId: '',
        condition: condition ?? 'Very Good',
        title: title ?? '',
        description: description ?? '',
        price: 1,
      );
    } else {
      _product = _product!.copyWith(
        productId: productId,
        ownerId: ownerId,
        condition: condition,
        title: title,
        description: description,
        imagesUrl: imagesUrl,
        price: price,
        productSellState: productSellState,
        locateCountry: locateCountry,
        locateCity: locateCity,
      );
    }

    notifyListeners();
  }

  void clearSaleProduct() {
    _product = null;
    images = [];
    notifyListeners();
  }

  bool productInProcess() {
    if (_product == null) return false;
    return _product!.title.isNotEmpty;
  }
}
