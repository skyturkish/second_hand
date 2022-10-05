import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/app/home/storage_image_view.dart';

class AdsView extends StatefulWidget {
  const AdsView({Key? key}) : super(key: key);

  @override
  State<AdsView> createState() => AdsViewState();
}

class AdsViewState extends State<AdsView> with AutomaticKeepAliveClientMixin {
  // TODO automatickeepaliveclientmixin'ini kaldırmayı dene
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: ProductCloudFireStoreService.instance
                .getAllOwnerProductsStream(userId: AuthService.firebase().currentUser!.id),
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
                        return MyAdsListTileProduct(product: product, mountainImagesRef: mountainImagesRef);
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
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MyAdsListTileProduct extends StatelessWidget {
  const MyAdsListTileProduct({
    Key? key,
    required this.product,
    required this.mountainImagesRef,
  }) : super(key: key);

  final Product product;
  final Reference mountainImagesRef;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // TODO let user to update his/her ads
      },
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
  }
}
