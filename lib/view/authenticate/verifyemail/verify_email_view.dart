import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/core/extensions/buildcontext/context_extension.dart';
import 'package:second_hand/services/auth/bloc/app_bloc.dart';
import 'package:second_hand/services/auth/bloc/app_event.dart';
import 'package:second_hand/view/_product/_widgets/button/custom_elevated_button.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  VerifyEmailViewState createState() => VerifyEmailViewState();
}

class VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Verify Email',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: context.paddingOnlyTopSmall,
                child: const Text(
                  "If you haven't received a verification email yet, press the buton below",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: context.paddingOnlyTopSmall,
                child: CustomElevatedButton(
                  onPressed: () {
                    context.read<AppBloc>().add(
                          const AppEventSendEmailVerification(),
                        );
                  },
                  child: const Text('Send email verification'),
                ),
              ),
              Padding(
                padding: context.paddingOnlyTopMedium,
                child: const Text(
                  "we've sent you an email... Please open it to verify your account",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: context.paddingOnlyTopSmall,
                child: CustomElevatedButton(
                  onPressed: () {
                    context.read<AppBloc>().add(
                          AppEventLogOut(context),
                        );
                  },
                  child: const Text(
                    'Login here!',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
