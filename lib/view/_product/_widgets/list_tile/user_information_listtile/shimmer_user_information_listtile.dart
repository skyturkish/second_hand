import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

@immutable
class ShimmerUserInformationListTile extends StatelessWidget {
  const ShimmerUserInformationListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.surface,
      highlightColor: context.colors.onSurface,
      child: ListTile(
        leading: const CircleAvatar(
          radius: 40,
          child: CircleAvatar(
            radius: 30,
          ),
        ),
        title: Container(
          height: 15,
          width: double.infinity,
          color: context.colors.background,
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
        ),
      ),
    );
  }
}
