import 'package:firebase_auth/firebase_auth.dart';
import 'package:second_hand/services/auth/auth_exceptions.dart';
import 'package:second_hand/services/auth/auth_provider.dart';
import 'package:second_hand/services/auth/auth_user.dart';

import 'auth_exceptions.dart';

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future<void>.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<void> deleteAccount() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future<void>.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'sky@sky.com') throw UserNotFoundAuthException();
    if (password == 'sky123') throw WrongPasswordAuthException();

    const user = AuthUser(
      id: 'my_id',
      isEmailVerified: false,
      email: 'sky@sky.com',
    );
    _user = user;

    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future<void>.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      id: 'my_id',
      isEmailVerified: true,
      email: 'sky@sky.com',
    );
    _user = newUser;
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGoogle() {
    throw UnimplementedError();
  }
}
