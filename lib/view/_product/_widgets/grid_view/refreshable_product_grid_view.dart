import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/_product/_widgets/card/product_card.dart';

typedef getAllProducts = Future<List<Product>?> Function({required String userId});

class RefreshsableProductGridView extends StatefulWidget {
  const RefreshsableProductGridView({
    super.key,
    required this.userId,
    required this.getProducts,
  });
  final String userId;
  final getAllProducts getProducts;
  @override
  State<RefreshsableProductGridView> createState() => _RefreshsableProductGridViewState();
}

class _RefreshsableProductGridViewState extends State<RefreshsableProductGridView> {
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    getAll();
  }

  Future<void> getAll() async {
    products = await widget.getProducts(userId: widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Text('----wait----')
        : RefreshIndicator(
            onRefresh: () async {
              getAll();
            },
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: products!.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products![index];
                return ProductCard(product: product);
              },
            ),
          );
  }
}
