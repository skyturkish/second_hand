import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/services/auth/auth_exceptions.dart';
import 'package:second_hand/services/auth/bloc/app_bloc.dart';
import 'package:second_hand/services/auth/bloc/app_event.dart';
import 'package:second_hand/services/auth/bloc/app_state.dart';
import 'package:second_hand/product/utilities/dialogs/error_dialog.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/authenticate/register/viewmodel/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
  });

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends RegisterViewModel {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is AppStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, context.loc.weakPassord);
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, context.loc.emailIsAlreadyInUse);
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, context.loc.failedToRegister);
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, context.loc.invalidEmail);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.register),
        ),
        body: Padding(
          padding: context.paddingAllMedium,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.loc.enterYourEmail),
                  EmailTextFormField(emailController: emailController),
                  PasswordTextFormField(passwordController: passwordController),
                  Center(
                    child: Column(
                      children: [
                        RegisterButton(emailController: emailController, passwordController: passwordController),
                        const AlreadyRegisterButton(),
                      ],
                    ),
                  ),
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
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: CustomTextFormField(
        controller: emailController,
        labelText: context.loc.email,
        prefix: const Icon(Icons.mail),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: CustomTextFormField(
        passwordTextFormField: true,
        controller: passwordController,
        labelText: context.loc.password,
        prefix: const Icon(
          Icons.password,
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final emailText = emailController.text;
        final passwordText = passwordController.text;
        context.read<AppBloc>().add(
              AppEventRegister(
                emailText,
                passwordText,
              ),
            );
      },
      child: Text(context.loc.register),
    );
  }
}

class AlreadyRegisterButton extends StatelessWidget {
  const AlreadyRegisterButton({
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
      child: Text(context.loc.alreadyRegistered),
    );
  }
}
