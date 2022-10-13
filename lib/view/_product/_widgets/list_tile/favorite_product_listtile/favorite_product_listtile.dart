import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/app/home/subview/product_detail_view.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailView(
                product: product,
              );
            },
          ),
        );
      },
      title: Text(product.title),
      subtitle: Text(product.description),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          product.imagesPath[0],
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          context.read<UserInformationNotifier>().removeFavoriteProduct(
                productId: product.productId,
              );
        },
        icon: const Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
    );
  }
}
