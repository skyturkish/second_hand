import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/_product/grid_view/product_grid_view.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class AdsView extends StatefulWidget {
  const AdsView({Key? key}) : super(key: key);

  @override
  State<AdsView> createState() => AdsViewState();
}

class AdsViewState extends State<AdsView> {
  final storageRef = FirebaseStorage.instance.ref();

  List<Product>? products;

  @override
  void initState() {
    super.initState();
    getAll();
  }

  Future<void> getAll() async {
    AuthService.firebase().currentUser!.id.log;
    products = await ProductCloudFireStoreService.instance
        .getAllOwnerProducts(ownerId: AuthService.firebase().currentUser!.id);
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
