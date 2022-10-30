import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.anErrorOccurred,
    content: text,
    optionsBuilder: () => {
      context.loc.buttonOk: null,
    },
  );
}
