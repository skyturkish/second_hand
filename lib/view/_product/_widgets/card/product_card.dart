import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/_product/_widgets/iconbutton/favorite_icon_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.instance.navigateToPage(
          path: NavigationConstants.PRODUCT_DETAIL,
          data: product,
        );
      },
      child: Card(
        elevation: 10,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: 'image ${product.productId}',
                      child: Image.network(
                        product.imagesPath[0],
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
            FavoriteIconButton(
              product: product,
            ),
          ],
        ),
      ),
    );
  }
}
