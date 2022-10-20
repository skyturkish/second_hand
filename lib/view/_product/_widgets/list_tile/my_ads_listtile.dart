import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';

@immutable
class MyProductsListTile extends StatelessWidget {
  const MyProductsListTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(product.title),
      subtitle: Text(product.description.overFlowString(limit: 70)),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          product.imagesUrl[0],
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
