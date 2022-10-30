import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';

Future<bool> keepSameProduct(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.dialogKeepSameProductTitle,
    content: context.loc.dialogKeepSameProductContent,
    optionsBuilder: () => {
      context.loc.buttonNo: false,
      context.loc.buttonYes: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
