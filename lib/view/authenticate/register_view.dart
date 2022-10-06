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

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
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
        if (state is AppStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak Password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email is already in use');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: context.paddingAllMedium,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Enter your email and password to see your notes!'),
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
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            final emailText = _emailController.text;
                            final passwordText = _passwordController.text;
                            context.read<AppBloc>().add(
                                  AppEventRegister(
                                    emailText,
                                    passwordText,
                                  ),
                                );
                          },
                          child: const Text('Register'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AppBloc>().add(
                                  const AppEventLogOut(),
                                );
                          },
                          child: const Text('Already registered? Login here!'),
                        ),
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
