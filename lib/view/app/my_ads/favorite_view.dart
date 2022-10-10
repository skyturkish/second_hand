import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/app/home/product_detail_view.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => FavoritesViewState();
}

class FavoritesViewState extends State<FavoritesView> with AutomaticKeepAliveClientMixin {
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: ProductCloudFireStoreService.instance
            .getAllFavoriteProductsStream(userId: AuthService.firebase().currentUser!.id, context: context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allProduct = snapshot.data as Iterable<Product>;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: allProduct.length,
                  itemBuilder: (context, index) {
                    final product = allProduct.elementAt(index);
                    final mountainImagesRef = storageRef.child(product.imagesPath[0]);
                    return FavoriteListTileProduct(product: product);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

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
