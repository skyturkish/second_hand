import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:second_hand/services/auth/auth_user.dart';

@immutable
abstract class AppState {
  const AppState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
  final bool isLoading;
  final String? loadingText;
}

class AppStateUninitialized extends AppState {
  const AppStateUninitialized({required super.isLoading});
}

class AppStateRegistering extends AppState {
  const AppStateRegistering({
    required this.exception,
    required super.isLoading,
  });
  final Exception? exception;
}

class AppStateForgotPassword extends AppState {
  const AppStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required super.isLoading,
  });
  final Exception? exception;
  final bool hasSentEmail;
}

class AppStateLoggedIn extends AppState {
  const AppStateLoggedIn({
    required this.user,
    required super.isLoading,
  });
  final AuthUser user;
}

class AppStateNeedsVerification extends AppState {
  const AppStateNeedsVerification({required super.isLoading});
}

class AppStateLoggedOut extends AppState with EquatableMixin {
  const AppStateLoggedOut({
    required this.exception,
    required super.isLoading,
    super.loadingText = null,
  });
  final Exception? exception;

  @override
  List<Object?> get props => [exception, isLoading];
}

class AppStateDeletedAccount extends AppState {
  const AppStateDeletedAccount({
    required this.exception,
    required super.isLoading,
    super.loadingText = null,
  });
  final Exception? exception;
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
