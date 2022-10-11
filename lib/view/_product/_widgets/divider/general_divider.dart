import 'package:flutter/material.dart';

class NormalDivider extends StatelessWidget {
  const NormalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 5,
      thickness: 10,
    );
  }
}
