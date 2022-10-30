import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/view/app/chats/widgets/blue_read_tick.dart';
import 'package:second_hand/view/app/chats/widgets/date_text.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({super.key, required this.message, required this.date, required this.isSeen});
  final String message;
  final String date;
  final bool isSeen;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.dynamicWidth(0.6),
          maxHeight: context.dynamicHeight(0.3),
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: context.colors.background,
          child: Padding(
            padding: context.paddingAllSmall * (2 / 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(child: Text(message)),
                DateText(date: date),
                BlueReadTick(isSeen: isSeen),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
