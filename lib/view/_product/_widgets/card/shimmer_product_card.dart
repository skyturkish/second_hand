import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/_product/_widgets/iconbutton/favorite_icon_button.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 90, 87, 87),
      highlightColor: const Color.fromARGB(255, 212, 206, 206),
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
                        width: context.dynamicWidth(0.40), height: context.dynamicHeight(0.20), color: Colors.grey),
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
