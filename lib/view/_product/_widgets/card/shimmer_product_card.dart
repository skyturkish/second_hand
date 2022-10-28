import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/buildcontext/context_extension.dart';
import 'package:shimmer/shimmer.dart';

@immutable
class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.surface,
      highlightColor: context.colors.onSurface,
      child: Card(
        elevation: 10,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: context.dynamicWidth(0.40),
                      height: context.dynamicHeight(0.20),
                      color: context.colors.background,
                    ),
                  ),
                ),
                Padding(
                    padding: context.paddingOnlyTopSmall,
                    child: SizedBox(
                      width: context.dynamicWidth(0.12),
                      height: 15,
                    )),
                Padding(
                    padding: context.paddingOnlyBottomSmall,
                    child: SizedBox(
                      width: context.dynamicWidth(0.16),
                      height: 15,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
