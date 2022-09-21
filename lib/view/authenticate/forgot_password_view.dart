import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/service/auth/bloc/app_bloc.dart';
import 'package:second_hand/service/auth/bloc/app_event.dart';
import 'package:second_hand/service/auth/bloc/app_state.dart';
import 'package:second_hand/utilities/dialogs/error_dialog.dart';
import 'package:second_hand/utilities/dialogs/password_reset_email_sent_dialog.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  ForgotPasswordViewState createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is AppStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
              context,
              'We could not process your request, Please make sure that you are a registered user, or if not, register a user now by going back one step',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'If you forgot your password, simply enter your email and we will send you a password',
                  ),
                  CustomTextFormField(
                    controller: _controller,
                    labelText: 'email',
                    hintText: 'Your email adres...',
                    prefix: const Icon(Icons.email),
                  ),
                  TextButton(
                    onPressed: () {
                      final email = _controller.text;
                      context.read<AppBloc>().add(AppEventForgotPassword(email: email));
                    },
                    child: const Text('Send me password reset link'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AppBloc>().add(
                            const AppEventLogOut(),
                          );
                    },
                    child: const Text('Back to login page'),
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
