import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/service/auth/bloc/app_bloc.dart';
import 'package:second_hand/service/auth/bloc/app_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  VerifyEmailViewState createState() => VerifyEmailViewState();
}

class VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verifiy email',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('we\'ve sent you an email... Please open it to verify your account'),
            const Text('If you haven\'t received a verification email yet, press the buton below'),
            TextButton(
              onPressed: () {
                context.read<AppBloc>().add(
                      const AppEventSendEmailVerification(),
                    );
              },
              child: const Text('Send email verification'),
            ),
            TextButton(
              onPressed: () async {
                context.read<AppBloc>().add(
                      const AppEventLogOut(),
                    );
              },
              child: const Text(
                'Restart',
              ),
            )
          ],
        ),
      ),
    );
  }
}
