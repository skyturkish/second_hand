import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';

class DateText extends StatelessWidget {
  const DateText({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyLeftSmallX + context.paddingOnlyLeftSmallX,
      child: Text(
        date,
        style: TextStyle(
          fontSize: 13,
          color: context.colors.onPrimary,
        ),
      ),
    );
  }
}
