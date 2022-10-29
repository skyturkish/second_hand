import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/buildcontext/loc.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: context.loc.dialogPasswordResetTitle,
    content: context.loc.dialogPasswordResetContent,
    optionsBuilder: () => {
      context.loc.buttonOk: null,
    },
  );
}
