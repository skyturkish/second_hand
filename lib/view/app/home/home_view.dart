import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  late final List<Product>? products;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getAll() async {
    //products = await GroupCloudFireStoreService.instance.getAllProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  return const Text('data');
                },
              ),
            ),
    );
  }
}
