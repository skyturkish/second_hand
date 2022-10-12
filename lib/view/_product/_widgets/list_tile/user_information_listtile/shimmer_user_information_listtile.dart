import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUserInformationListTile extends StatelessWidget {
  const ShimmerUserInformationListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 90, 87, 87),
      highlightColor: const Color.fromARGB(255, 212, 206, 206),
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
          color: Colors.grey,
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
        ),
      ),
    );
  }
}
