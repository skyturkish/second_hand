import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/_product/_widgets/iconbutton/favorite_icon_button.dart';
import 'package:second_hand/view/app/home/subview/product_detail_view_model.dart';

@immutable
class FavoriteListTileProduct extends StatelessWidget {
  const FavoriteListTileProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<ProductDetailViewModelNotifier>().resetPageIndex();
        NavigationService.instance.navigateToPage(
          path: NavigationConstants.PRODUCT_DETAIL,
          data: product,
        );
      },
      title: Text(product.title),
      subtitle: Text(product.description),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          product.imagesUrl[0],
        ),
      ),
      trailing: FavoriteIconButton(
        product: product,
      ),
    );
  }
}
