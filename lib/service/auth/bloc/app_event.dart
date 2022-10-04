import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent {
  const AppEvent();
}

class AppEventInitialize extends AppEvent {
  const AppEventInitialize();
}

class AppEventSendEmailVerification extends AppEvent {
  const AppEventSendEmailVerification();
}

class AppEventLogIn extends AppEvent {
  final String email;
  final String password;
  const AppEventLogIn(this.email, this.password);
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
