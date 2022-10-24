import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/product.dart';

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
    String? documentId,
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
        condition: condition!,
        title: title!,
        description: description!,
        price: 1,
      );
    } else {
      _product = _product!.copyWith(
        productId: productId,
        documentId: documentId,
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

  void clearProduct() {
    _product = null;
    notifyListeners();
  }

  bool productInProcess() {
    if (_product == null) return false;
    return _product!.title.isNotEmpty;
  }
}
