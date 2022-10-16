import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/context_extension.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        Padding(
          padding: context.paddingOnlyTopSmall,
          child: Text(text),
        ),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => dialog,
  );

  return () => Navigator.of(context).pop();
}
