import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/app/home/storage_image_view.dart';

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
    products = await GroupCloudFireStoreService.instance.getAllProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const CircularProgressIndicator()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: products!.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products![index];
                final mountainImagesRef = storageRef.child(product.imagesPath[0]);

                return Column(
                  children: [
                    Expanded(
                      child: StorageImageView(
                        image: mountainImagesRef,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
