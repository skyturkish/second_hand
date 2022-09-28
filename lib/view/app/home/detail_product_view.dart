import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/app/home/storage_image_view.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({Key? key, required this.product, required this.storageRef}) : super(key: key);
  final Product product;
  final Reference storageRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductDetail'),
      ),
      body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  itemCount: product.imagesPath.length,
                  itemBuilder: (context, index) {
                    final mountainImagesRef = storageRef.child(product.imagesPath[index]);
                    return StorageImageView(
                      image: mountainImagesRef,
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
