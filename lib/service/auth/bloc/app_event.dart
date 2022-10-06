import 'package:flutter/cupertino.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

class AppEventInitialize extends AppEvent {
  const AppEventInitialize(this.context);
  final BuildContext context;
}

class AppEventSendEmailVerification extends AppEvent {
  const AppEventSendEmailVerification();
}

class AppEventLogIn extends AppEvent {
  const AppEventLogIn(this.email, this.password, this.context);
  final String email;
  final String password;
  final BuildContext context;
}

class AppEventRegister extends AppEvent {
  const AppEventRegister(this.email, this.password);
  final String email;
  final String password;
}

class AppEventShouldRegister extends AppEvent {
  const AppEventShouldRegister();
}

class AppEventForgotPassword extends AppEvent {
  const AppEventForgotPassword({this.email});
  final String? email;
}

class AppEventLogOut extends AppEvent {
  const AppEventLogOut();
}

class AppEventDeleteAccount extends AppEvent {
  const AppEventDeleteAccount();
}
