import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/buildcontext/context_extension.dart';
import 'package:shimmer/shimmer.dart';

@immutable
class ShimmerFavoriteListTileProduct extends StatelessWidget {
  const ShimmerFavoriteListTileProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.surface,
      highlightColor: context.colors.onSurface,
      child: ListTile(
        title: Container(
          height: 15,
          width: 100,
          color: context.colors.background,
        ),
        subtitle: Column(
          children: [
            Container(
              height: 15,
              width: double.infinity,
              color: context.colors.background,
            ),
            Container(
              height: 15,
              width: 250,
              color: context.colors.background,
            )
          ],
        ),
        leading: const CircleAvatar(
          radius: 30,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite,
            color: context.colors.error,
          ),
        ),
      ),
    );
  }
}
