import 'package:flutter/material.dart';
import 'package:second_hand/product/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password reset',
    content: 'We have now sent you a pssword reset link. Please Chech your email for more information',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
