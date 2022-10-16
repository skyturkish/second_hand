import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';

@immutable
class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    final isFavorite =
        context.watch<UserInformationNotifier>().userInformation.favoriteProducts.contains(widget.product.productId);
    return IconButton(
      onPressed: () {
        isFavorite
            ? context.read<UserInformationNotifier>().removeFavoriteProduct(productId: widget.product.productId)
            : context.read<UserInformationNotifier>().addFavoriteProduct(productId: widget.product.productId);
        setState(() {});
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? context.colors.error : context.colors.surface,
      ),
    );
  }
}
