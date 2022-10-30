import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/favorite_product_listtile/favorite_product_listtile.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => FavoritesViewState();
}

class FavoritesViewState extends State<FavoritesView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StreamMyFavoriteProductsStream(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class StreamMyFavoriteProductsStream extends StatelessWidget {
  const StreamMyFavoriteProductsStream({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ProductCloudFireStoreService.instance
          .getAllFavoriteProductsStream(userId: AuthService.firebase().currentUser!.id, context: context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            if (!snapshot.hasData) {
              return const Text('');
            } else {
              final allProduct = snapshot.data as Iterable<Product>;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: allProduct.length,
                itemBuilder: (context, index) {
                  final product = allProduct.elementAt(index);
                  return FavoriteListTileProduct(product: product);
                },
              );
            }
          default:
            return const Text('');
        }
      },
    );
  }
}
