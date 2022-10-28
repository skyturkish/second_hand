import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/my_product_listtile.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({Key? key}) : super(key: key);

  @override
  State<MyProductsView> createState() => MyProductsViewState();
}

class MyProductsViewState extends State<MyProductsView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          StreamMyProductsProducts(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class StreamMyProductsProducts extends StatelessWidget {
  const StreamMyProductsProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                  return MyProductsListTile(product: product);
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}