import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/core/extensions/buildcontext/context_extension.dart';
import 'package:second_hand/core/extensions/buildcontext/loc.dart';
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
            context.loc.verifyEmail,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: context.paddingOnlyTopSmall,
                child: Text(
                  context.loc.ifYouHavenotReceived,
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
                  child: Text(context.loc.sendEmailVerification),
                ),
              ),
              Padding(
                padding: context.paddingOnlyTopMedium,
                child: Text(
                  context.loc.weHaveSentYouAnEmail,
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
                  child: Text(
                    context.loc.loginHere,
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
