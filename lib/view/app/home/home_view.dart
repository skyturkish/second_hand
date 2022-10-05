import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/_product/_widgets/grid_view/product_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final storageRef = FirebaseStorage.instance.ref();

  List<Product>? products;

  @override
  void initState() {
    super.initState();
    getAll();
  }

  Future<void> getAll() async {
    products =
        //TODO authservice'den okayacağına kendi yaptığın providerdan oku
        await ProductCloudFireStoreService.instance.getAllProducts(userId: AuthService.firebase().currentUser!.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const CircularProgressIndicator()
          : RefreshIndicator(
              onRefresh: () async {
                getAll();
              },
              child: ProductGridView(products: products, storageRef: storageRef),
            ),
    );
  }
}
