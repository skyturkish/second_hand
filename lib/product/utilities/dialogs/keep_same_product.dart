import 'package:flutter/material.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';

Future<bool> keepSameProduct(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Keep on same product',
    content: 'Do you want to work on same product',
    optionsBuilder: () => {
      'No': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
