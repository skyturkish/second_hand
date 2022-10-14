import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/context_extension.dart';

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
          color: Colors.grey, // değiştir bunu
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: context.paddingOnlyLeftSmallX,
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white60,
                  ),
                ),
              ),
              Flexible(child: Text('     $message')),
            ],
          ),
        ),
      ),
    );
  }
}
