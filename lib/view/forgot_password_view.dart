import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/service/bloc/app_bloc.dart';
import 'package:second_hand/service/bloc/app_event.dart';
import 'package:second_hand/service/bloc/app_state.dart';
import 'package:second_hand/utilities/dialogs/error_dialog.dart';
import 'package:second_hand/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
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
            child: Column(
              children: [
                const Text(
                  'If you forgot your password, simply enter your email and we will send you a password',
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autofocus: true,
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Your email adres....',
                  ),
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
    );
  }
}
