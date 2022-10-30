import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';

class DateText extends StatelessWidget {
  const DateText({
    Key? key,
    required this.date,
  }) : super(key: key);

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
