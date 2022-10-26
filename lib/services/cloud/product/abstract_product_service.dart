import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:second_hand/models/product.dart';

abstract class IProductCloudFireStoreService {
  Future<void> createProduct({required Product product, required List<File> images});
  Future<List<Product>?> getAllBelongProducts({required String userId});
  Future<List<Product>?> getAllNotBelongProducts({required String userId});
  Future<Product>? getProductById({required String productId});
  Future<void> updateProductDescription({required String productId, required String newDescription});
  Future<void> removeProduct({required Product product});
  Future<void> removeAllProductsById({required String userId});
  Stream<Iterable<Product>> getAllOwnerProductsStream({required String userId});
  Stream<Iterable<Product>> getAllFavoriteProductsStream({required String userId, required BuildContext context});
}
