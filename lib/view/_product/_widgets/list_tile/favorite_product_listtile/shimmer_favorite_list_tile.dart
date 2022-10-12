import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/app/home/subview/product_detail_view.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFavoriteListTileProduct extends StatelessWidget {
  const ShimmerFavoriteListTileProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 90, 87, 87),
      highlightColor: const Color.fromARGB(255, 212, 206, 206),
      child: ListTile(
        title: Container(
          height: 15,
          width: 100,
          color: Colors.grey,
        ),
        subtitle: Column(
          children: [
            Container(
              height: 15,
              width: double.infinity,
              color: Colors.grey,
            ),
            Container(
              height: 15,
              width: 250,
              color: Colors.grey,
            )
          ],
        ),
        leading: const CircleAvatar(
          radius: 30,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
