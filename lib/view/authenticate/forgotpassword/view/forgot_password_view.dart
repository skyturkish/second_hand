import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/product/utilities/dialogs/error_dialog.dart';
import 'package:second_hand/product/utilities/dialogs/password_reset_email_sent_dialog.dart';
import 'package:second_hand/services/auth/bloc/app_bloc.dart';
import 'package:second_hand/services/auth/bloc/app_event.dart';
import 'package:second_hand/services/auth/bloc/app_state.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/authenticate/forgotpassword/viewmodel/forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    super.key,
  });

  @override
  ForgotPasswordViewState createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends ForgotPasswordViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is AppStateForgotPassword) {
          if (state.hasSentEmail) {
            controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
              context,
              context.loc.weCouldNotProcessYourRequest,
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.forgotPassword),
        ),
        body: Padding(
          padding: context.paddingAllMedium,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(context.loc.ifYouForgotYourPassword),
                  EmailTextFormField(controller: controller),
                  SendPasswordButton(controller: controller),
                  const BackToLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: CustomTextFormField(
        controller: controller,
        labelText: 'email',
        hintText: 'email',
        prefix: const Icon(Icons.email),
      ),
    );
  }
}

class SendPasswordButton extends StatelessWidget {
  const SendPasswordButton({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final email = controller.text.replaceAll(' ', '');
        context.read<AppBloc>().add(AppEventForgotPassword(email: email));
      },
      child: const Text('Send me password reset link'),
    );
  }
}

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<AppBloc>().add(
              AppEventLogOut(context),
            );
      },
      child: const Text('Back to login page'),
    );
  }
}
