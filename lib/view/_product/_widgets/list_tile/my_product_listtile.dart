import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
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
      trailing: PopupMenuButton<MyProductAction>(
        onSelected: (value) async {
          switch (value) {
            case MyProductAction.edit:
              NavigationService.instance.navigateToPage(
                path: NavigationConstants.PRODUCT_DETAIL,
                data: product,
              );
              return;
            case MyProductAction.delete:
              await ProductCloudFireStoreService.instance.removeProduct(
                product: product,
              );
              return;
          }
        },
        itemBuilder: (context) {
          return [
            const PopupMenuItem<MyProductAction>(
              value: MyProductAction.edit,
              child: Text('edit'),
            ),
            const PopupMenuItem<MyProductAction>(
              value: MyProductAction.delete,
              child: Text('delete'),
            ),
          ];
        },
      ),
    );
  }
}

enum MyProductAction {
  edit,
  delete;
}
