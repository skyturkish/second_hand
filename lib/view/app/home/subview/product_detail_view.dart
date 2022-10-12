import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/_product/_widgets/iconbutton/favorite_icon_button.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/user_information_listtile.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.product});
  final Product product;
//TODO product vdetail view'i düzelt hacım
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Hero(
              tag: 'image ${product.productId}',
              child: SizedBox(
                height: context.dynamicHeight(0.33),
                width: context.dynamicWidth(0.90),
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  itemCount: product.imagesPath.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      product.imagesPath[index],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: context.paddingHorizontalSmall + context.paddingOnlyTopSmall,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price} TL',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Padding(
                        padding: context.paddingOnlyTopSmall,
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                  FavoriteIconButton(
                    product: product,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: context.paddingHorizontalSmall,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: context.paddingOnlyTopSmall,
                    child: Text(
                      'Description',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: context.paddingOnlyTopSmall,
                    child: Text(
                      product.description,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            UserInformationListtile(userId: product.ownerId),
          ],
        ),
      ),
    );
  }
}
