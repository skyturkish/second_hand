import 'package:flutter/material.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';

Future<bool> ignoreChanges(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Ignore Changes',
    content: 'Are you sure you ignore the changes?',
    optionsBuilder: () => {
      'Cancel': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
