import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/product/product.dart';
import 'package:second_hand/product/utilities/cached_image/cache_image.dart';
import 'package:second_hand/view/_product/_widgets/iconbutton/favorite_icon_button.dart';
import 'package:second_hand/view/_product/_widgets/row/location_information_row.dart';
import 'package:second_hand/view/app/home/subview/product_detail_view_model.dart';

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
        context.read<ProductDetailViewModelNotifier>().resetPageIndex();
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
                      child: ShowCachedImageOrFromNetwork(
                        networkUrl: product.imagesUrl.first,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: context.paddingOnlyTopSmall,
                  child: Text(
                    '${product.price}' ' \$',
                    style: Theme.of(context).textTheme.subtitle2,
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
                LocationInformationRow(product: product),
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
