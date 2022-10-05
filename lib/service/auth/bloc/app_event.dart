import 'package:flutter/cupertino.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

class AppEventInitialize extends AppEvent {
  final BuildContext context;
  const AppEventInitialize(this.context);
}

class AppEventSendEmailVerification extends AppEvent {
  const AppEventSendEmailVerification();
}

class AppEventLogIn extends AppEvent {
  final String email;
  final String password;
  final BuildContext context;
  const AppEventLogIn(this.email, this.password, this.context);
}

class AppEventRegister extends AppEvent {
  final String email;
  final String password;
  const AppEventRegister(this.email, this.password);
}

class AppEventShouldRegister extends AppEvent {
  const AppEventShouldRegister();
}

class AppEventForgotPassword extends AppEvent {
  final String? email;
  const AppEventForgotPassword({this.email});
}

class AppEventLogOut extends AppEvent {
  const AppEventLogOut();
}

class AppEventDeleteAccount extends AppEvent {
  const AppEventDeleteAccount();
}
