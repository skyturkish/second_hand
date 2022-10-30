import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';

class BlueReadTick extends StatelessWidget {
  const BlueReadTick({
    super.key,
    required this.isSeen,
  });

  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyLeftSmallX,
      child: Icon(
        isSeen ? Icons.done_all : Icons.done,
        size: 20,
        color: isSeen ? Colors.blue : context.colors.onPrimary,
      ),
    );
  }
}
