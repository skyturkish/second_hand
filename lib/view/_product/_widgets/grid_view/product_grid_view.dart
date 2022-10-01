import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/app/home/home_product_card.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    Key? key,
    required this.products,
    required this.storageRef,
  }) : super(key: key);

  final List<Product>? products;
  final Reference storageRef;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: products!.length,
      itemBuilder: (BuildContext context, int index) {
        final product = products![index];
        final mountainImagesRef = storageRef.child(product.imagesPath[0]);
        return CardHomeProduct(product: product, storageRef: storageRef, mountainImagesRef: mountainImagesRef);
      },
    );
  }
}
