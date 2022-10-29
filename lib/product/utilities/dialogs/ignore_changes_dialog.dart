import 'package:flutter/material.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';
import 'package:second_hand/core/extensions/buildcontext/loc.dart';

Future<bool> ignoreChanges(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.dialogIgnoreChangesTitle,
    content: context.loc.dialogIgnoreChangesContent,
    optionsBuilder: () => {
      context.loc.buttonCancel: false,
      context.loc.buttonYes: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
