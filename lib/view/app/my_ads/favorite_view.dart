import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/app/home/storage_image_view.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

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
                    return ListTile(
                      title: Text(product.title),
                      subtitle: Text(product.description),
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: StorageImageView(
                          image: mountainImagesRef,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          ProductCloudFireStoreService.instance.removeProduct(
                            productId: product.productId,
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
