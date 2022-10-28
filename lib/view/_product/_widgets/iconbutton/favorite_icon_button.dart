import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/buildcontext/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<UserInformationNotifier>().userInformation!.favoriteProducts.contains(
          product.productId,
        );
    return IconButton(
      onPressed: () async {
        if (!isFavorite) {
          context.read<UserInformationNotifier>().addFavoriteProductLocal(productId: product.productId);

          await UserCloudFireStoreService.instance.addProductToFavorites(
            userId: AuthService.firebase().currentUser!.id,
            productId: product.productId,
          );
        } else {
          context.read<UserInformationNotifier>().removeFavoriteProductLocal(productId: product.productId);
          await UserCloudFireStoreService.instance.removeProductToFavorites(
            userId: AuthService.firebase().currentUser!.id,
            productId: product.productId,
          );
        }
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? context.colors.error : context.colors.surface,
      ),
    );
  }
}
