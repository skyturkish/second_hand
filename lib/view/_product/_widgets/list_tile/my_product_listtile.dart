import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/string/string_extension.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';

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
      subtitle: Text(
        product.description.overFlowString(limit: 70),
      ),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          product.imagesUrl.first,
        ),
      ),
      trailing: PopupMenuButton<MyProductAction>(
        onSelected: (value) async {
          switch (value) {
            case MyProductAction.delete:
              await ProductCloudFireStoreService.instance.setProductAsRemoved(
                product: product,
              );

              return;
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem<MyProductAction>(
              value: MyProductAction.delete,
              child: Text(context.loc.delete),
            ),
          ];
        },
      ),
    );
  }
}

enum MyProductAction {
  delete;
}
