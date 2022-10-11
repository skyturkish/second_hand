import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';

class MyProductsListTileProduct extends StatelessWidget {
  const MyProductsListTileProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(product.title),
      subtitle: Text(product.description),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          product.imagesPath[0],
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          ProductCloudFireStoreService.instance.removeProduct(
            productId: product.productId,
          );
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
