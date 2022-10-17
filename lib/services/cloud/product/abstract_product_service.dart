import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:second_hand/models/product.dart';

abstract class IProductCloudFireStoreService {
  Future<void> createProduct({required Product product, required List<File> images});
  Future<List<Product>?> getAllBelongProducts({required String userId});
  Future<List<Product>?> getAllNotBelongProducts({required String userId});
  Future<void> removeProduct({required String productId});
  Future<void> removeAllProductWithImages({required String userId});
  Stream<Iterable<Product>> getAllOwnerProductsStream({required String userId});
  Stream<Iterable<Product>> getAllFavoriteProductsStream({required String userId, required BuildContext context});
}