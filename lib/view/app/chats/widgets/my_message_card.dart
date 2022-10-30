import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/view/app/chats/widgets/blue_read_tick.dart';
import 'package:second_hand/view/app/chats/widgets/date_text.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({super.key, required this.message, required this.date, required this.isSeen});
  final String message;
  final String date;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.dynamicWidth(0.6),
          maxHeight: context.dynamicHeight(0.3),
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: context.colors.background,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: Text('    $message')),
              Row(
                children: [
                  DateText(date: date),
                  BlueReadTick(isSeen: isSeen),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
