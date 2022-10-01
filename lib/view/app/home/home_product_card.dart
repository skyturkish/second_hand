import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/app/home/detail_product_view.dart';
import 'package:second_hand/view/app/home/storage_image_view.dart';

class CardHomeProduct extends StatelessWidget {
  const CardHomeProduct({
    Key? key,
    required this.product,
    required this.storageRef,
    required this.mountainImagesRef,
  }) : super(key: key);

  final Product product;
  final Reference storageRef;
  final Reference mountainImagesRef;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductDetailView(
                          product: product,
                          storageRef: storageRef,
                        );
                      },
                    ),
                  );
                },
                child: Center(
                  child: StorageImageView(
                    image: mountainImagesRef,
                  ),
                ),
              ),
            ),
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: Text(
                product.price.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: context.paddingOnlyBottomSmall,
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
