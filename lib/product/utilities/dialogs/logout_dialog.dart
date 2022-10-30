import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.dialogLogOutTitle,
    content: context.loc.dialogLogOutContent,
    optionsBuilder: () => {
      context.loc.buttonCancel: false,
      context.loc.logout: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
