import 'package:firebase_auth/firebase_auth.dart';
import 'package:second_hand/service/auth/auth_provider.dart';
import 'package:second_hand/service/auth/auth_user.dart';

class MockAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({required String email, required String password}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) {
    // TODO: implement sendPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
