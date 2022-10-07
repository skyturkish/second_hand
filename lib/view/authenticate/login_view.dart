import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/if_debugging.dart';
import 'package:second_hand/service/auth/auth_exceptions.dart';
import 'package:second_hand/service/auth/bloc/app_bloc.dart';
import 'package:second_hand/service/auth/bloc/app_event.dart';
import 'package:second_hand/service/auth/bloc/app_state.dart';
import 'package:second_hand/utilities/dialogs/error_dialog.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'gokturk.acr2002@gmail.com'.ifDebugging);
    _passwordController = TextEditingController(text: 'deniyorum123'.ifDebugging);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is AppStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, 'Cannot find a user with the entered credentials!');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: context.paddingAllMedium,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Please log in to your account in order to interact with and create notes and talk friends',
                  ),
                  Padding(
                    padding: context.paddingOnlyTopSmall,
                    child: CustomTextFormField(
                      controller: _emailController,
                      labelText: 'email',
                      prefix: const Icon(Icons.mail),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: context.paddingOnlyTopSmall,
                    child: CustomTextFormField(
                      passwordTextFormField: true,
                      controller: _passwordController,
                      labelText: 'password',
                      prefix: const Icon(
                        Icons.password,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final emailText = _emailController.text;
                      final passwordText = _passwordController.text;
                      context.read<AppBloc>().add(
                            AppEventLogIn(
                              emailText,
                              passwordText,
                              context,
                            ),
                          );
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AppBloc>().add(
                            const AppEventForgotPassword(),
                          );
                    },
                    child: const Text('I forgot my password'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<AppBloc>().add(
                            AppEventLogInWithGoogle(context),
                          );
                    },
                    child: const Text('Sign in with google'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AppBloc>().add(
                            const AppEventShouldRegister(),
                          );
                    },
                    child: const Text('Not registered yet? Register here!'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
