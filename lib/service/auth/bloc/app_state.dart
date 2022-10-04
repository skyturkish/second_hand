import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';
import 'package:second_hand/service/auth/auth_user.dart';

@immutable
abstract class AppState {
  final bool isLoading;
  final String? loadingText;
  const AppState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

class AppStateUninitialized extends AppState {
  const AppStateUninitialized({required bool isLoading}) : super(isLoading: isLoading);
}

class AppStateRegistering extends AppState {
  final Exception? exception;
  const AppStateRegistering({
    required this.exception,
    required isLoading,
  }) : super(isLoading: isLoading);
}

class AppStateForgotPassword extends AppState {
  final Exception? exception;
  final bool hasSentEmail;
  const AppStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AppStateLoggedIn extends AppState {
  final AuthUser user;
  const AppStateLoggedIn({
    required this.user,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AppStateNeedsVerification extends AppState {
  const AppStateNeedsVerification({required bool isLoading}) : super(isLoading: isLoading);
}

class AppStateLoggedOut extends AppState with EquatableMixin {
  final Exception? exception;
  const AppStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(
          isLoading: isLoading,
          loadingText: loadingText,
        );

  @override
  List<Object?> get props => [exception, isLoading];
}

class AppStateDeletedAccount extends AppState {
  final Exception? exception;

  const AppStateDeletedAccount({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(
          isLoading: isLoading,
          loadingText: loadingText,
        );
}

extension GetUser on AppState {
  AuthUser? get user {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}
