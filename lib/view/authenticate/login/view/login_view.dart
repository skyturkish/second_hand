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
import 'package:second_hand/view/authenticate/login/viewmdoel/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends LoginViewmodel {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is AppStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, context.loc.cannotFindAUser);
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, context.loc.wrongCredentials);
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, context.loc.authenticationError);
          } else if (state.exception is UserRequiresRecentLogin) {
            await showErrorDialog(context, context.loc.theAccountCouldNotBeDeleted);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.login),
        ),
        body: Padding(
          padding: context.paddingAllMedium,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(context.loc.pleaseLogUnToYourAccount),
                  EmailTextFormField(emailController: emailController),
                  PasswordTextFormField(passwordController: passwordController),
                  LoginButton(emailController: emailController, passwordController: passwordController),
                  const ForgotPasswordButton(),
                  const SignInWithGoogleButton(),
                  const NotRegisterYetButton()
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
    Key? key,
    required this.emailController,
  }) : super(key: key);

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
    Key? key,
    required this.passwordController,
  }) : super(key: key);

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

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final emailText = emailController.text;
        final passwordText = passwordController.text;
        context.read<AppBloc>().add(
              AppEventLogIn(
                emailText,
                passwordText,
                context,
              ),
            );
      },
      child: Text(context.loc.login),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<AppBloc>().add(
              const AppEventForgotPassword(),
            );
      },
      child: Text(context.loc.iForgotMyPassword),
    );
  }
}

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        context.read<AppBloc>().add(
              AppEventLogInWithGoogle(context),
            );
      },
      child: Text(context.loc.signInWithGoogle),
    );
  }
}

class NotRegisterYetButton extends StatelessWidget {
  const NotRegisterYetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<AppBloc>().add(
              const AppEventShouldRegister(),
            );
      },
      child: Text(context.loc.notRegisteredYet),
    );
  }
}
