import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final isFavorite =
        context.watch<UserInformationNotifier>().userInformation.favoriteProducts.contains(product.productId);
    return IconButton(
      onPressed: () {
        isFavorite
            ? context.read<UserInformationNotifier>().removeFavoriteProduct(productId: product.productId)
            : context.read<UserInformationNotifier>().addFavoriteProduct(productId: product.productId);
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? context.colors.error : context.colors.surface,
      ),
    );
  }
}
