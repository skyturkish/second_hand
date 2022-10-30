import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.dialogDeleteAccountTitle,
    content: context.loc.dialogDeleteAccountContent,
    optionsBuilder: () => {
      context.loc.buttonCancel: false,
      context.loc.buttonYes: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
