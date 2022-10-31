// ignore_for_file: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

import 'package:flutter/material.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/_product/_widgets/card/product_card.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.query,
  });
  final Query<Map<String, dynamic>> query;
  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Map<String, dynamic>>(
      query: query,
      builder: (context, snapshot, _) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
          ),
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              snapshot.fetchMore();
            }

            final product = Product.fromMap(snapshot.docs[index].data());

            return ProductCard(product: product);
          },
        );
      },
    );
  }
}

/**products == null
        ? const LottieAnimationView(animation: LottieAnimation.loading)
        : products!.isEmpty
            ? Center(
                child: Text(
                  context.loc.noOneSellTheProducts,
                  style: Theme.of(context).textTheme.headline5,
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  getAll();
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: products!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products![index];
                    return ProductCard(product: product);
                  },
                ),
              ); */