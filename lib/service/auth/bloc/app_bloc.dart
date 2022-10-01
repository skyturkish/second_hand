import 'package:bloc/bloc.dart';
import 'package:second_hand/service/auth/auth_provider.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/auth/bloc/app_event.dart';
import 'package:second_hand/service/auth/bloc/app_state.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(AuthProvider provider) : super(const AppStateUninitialized(isLoading: true)) {
    on<AppEventShouldRegister>((event, emit) {
      emit(const AppStateRegistering(
        exception: null,
        isLoading: false,
      ));
    });
    //forgot password
    on<AppEventForgotPassword>((event, emit) async {
      emit(const AppStateForgotPassword(
        exception: null,
        hasSentEmail: false,
        isLoading: false,
      ));
      final email = event.email;
      if (email == null) {
        return; // user just wants to go to forgot-password screen
      }

      // user wants to actually send a forgot-password email
      emit(const AppStateForgotPassword(
        exception: null,
        hasSentEmail: false,
        isLoading: true,
      ));

      bool didSendEmail;
      Exception? exception;
      try {
        await provider.sendPasswordReset(toEmail: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (e) {
        didSendEmail = false;
        exception = e;
      }

      emit(AppStateForgotPassword(
        exception: exception,
        hasSentEmail: didSendEmail,
        isLoading: false,
      ));
    });
    // send email verification
    on<AppEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });
    on<AppEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(const AppStateNeedsVerification(isLoading: false));
      } on Exception catch (e) {
        emit(AppStateRegistering(
          exception: e,
          isLoading: false,
        ));
      }
    });
    // initialize
    on<AppEventInitialize>(
      (event, emit) async {
        await provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(
            const AppStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
        } else if (!user.isEmailVerified) {
          emit(
            const AppStateNeedsVerification(
              isLoading: false,
            ),
          );
        } else {
          emit(
            AppStateLoggedIn(
              user: user,
              isLoading: false,
            ),
          );
        }
      },
    );
    // log in
    on<AppEventLogIn>((event, emit) async {
      emit(
        const AppStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: 'Please wait while I log you in',
        ),
      );
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );

        if (!user.isEmailVerified) {
          emit(
            const AppStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(const AppStateNeedsVerification(isLoading: false));
        } else {
          emit(
            const AppStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(
            AppStateLoggedIn(
              user: user,
              isLoading: false,
            ),
          );
          await UserCloudFireStoreService.instance.createUser(userId: AuthService.firebase().currentUser!.id);
        }
      } on Exception catch (e) {
        emit(
          AppStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
    // log out
    on<AppEventLogOut>(
      (event, emit) async {
        try {
          await provider.logOut();
          emit(
            const AppStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
        } on Exception catch (e) {
          emit(
            AppStateLoggedOut(
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );

    //   on<AppEventGoToAccount>(
    //     (event, emit) async {
    //       final user = FirebaseAuth.instance.currentUser;
    //       // log the user out if we don't have a current user
    //       if (user == null) {
    //         emit(
    //           const AppStateLoggedOut(
    //             isLoading: false,
    //             exception: null,
    //           ),
    //         );
    //         return;
    //       }
    //       emit(
    //         const AppStateInAccountView(
    //           exception: null,
    //           isLoading: false,
    //         ),
    //       );
    //     },
    //   );
    //   on<AppEventGoToMyAds>(
    //     (event, emit) async {
    //       final user = FirebaseAuth.instance.currentUser;
    //       // log the user out if we don't have a current user
    //       if (user == null) {
    //         emit(
    //           const AppStateLoggedOut(
    //             isLoading: false,
    //             exception: null,
    //           ),
    //         );
    //         return;
    //       }
    //       emit(
    //         const AppStateInMyAds(
    //           exception: null,
    //           isLoading: false,
    //         ),
    //       );
    //     },
    //   );
    //   on<AppEventGoToChats>(
    //     (event, emit) async {
    //       final user = FirebaseAuth.instance.currentUser;
    //       // log the user out if we don't have a current user
    //       if (user == null) {
    //         emit(
    //           const AppStateLoggedOut(
    //             isLoading: false,
    //             exception: null,
    //           ),
    //         );
    //         return;
    //       }
    //       emit(
    //         const AppStateInChats(
    //           exception: null,
    //           isLoading: false,
    //         ),
    //       );
    //     },
    //   );
    //   on<AppEventGoToHome>(
    //     (event, emit) async {
    //       final user = FirebaseAuth.instance.currentUser;
    //       // log the user out if we don't have a current user
    //       if (user == null) {
    //         emit(
    //           const AppStateLoggedOut(
    //             isLoading: false,
    //             exception: null,
    //           ),
    //         );
    //         return;
    //       }
    //       emit(
    //         const AppStateInHome(
    //           exception: null,
    //           isLoading: false,
    //         ),
    //       );
    //     },
    //   );
    //
  }
}
