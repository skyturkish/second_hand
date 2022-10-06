import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/app/home/detail_product_view.dart';
import 'package:second_hand/view/app/home/storage_image_view.dart';

class CardHomeProduct extends StatelessWidget {
  const CardHomeProduct({
    super.key,
    required this.product,
    required this.storageRef,
    required this.mountainImagesRef,
  });

  final Product product;
  final Reference storageRef;
  final Reference mountainImagesRef;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
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
          FavoriteIconButton(
            product: product,
            provider: context.read<UserInformationNotifier>(),
          ),
        ],
      ),
    );
  }
}

class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({
    super.key,
    required this.product,
    required this.provider,
  });

  final Product product;
  final UserInformationNotifier provider;

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    final isFavorite = widget.provider.userInformation.favoriteAds.contains(widget.product.productId);
    return IconButton(
      onPressed: () {
        isFavorite
            ? widget.provider.removeFavoriteProduct(productId: widget.product.productId)
            : widget.provider.addFavoriteProduct(productId: widget.product.productId);
        setState(() {});
      },
      icon: Icon(
        Icons.favorite,
        color: isFavorite ? Colors.red : Colors.black,
      ),
    );
  }
}
