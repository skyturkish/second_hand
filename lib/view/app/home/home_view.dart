import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/core/extension/context_extension.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/app/home/detail_product_view.dart';
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
          : RefreshIndicator(
              onRefresh: () async {
                getAll();
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: products!.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = products![index];
                  final mountainImagesRef = storageRef.child(product.imagesPath[0]);
                  return Card(
                    child: Column(
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
                  );
                },
              ),
            ),
    );
  }
}
