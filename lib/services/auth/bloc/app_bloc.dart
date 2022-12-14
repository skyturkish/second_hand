import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/services/auth/auth_provider.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/auth/bloc/app_event.dart';
import 'package:second_hand/services/auth/bloc/app_state.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(AuthProvider provider) : super(const AppStateUninitialized(isLoading: true)) {
    on<AppEventShouldRegister>(
      (event, emit) {
        emit(
          const AppStateRegistering(
            exception: null,
            isLoading: false,
          ),
        );
      },
    );

    // Forgot password
    on<AppEventForgotPassword>(
      (event, emit) async {
        emit(
          const AppStateForgotPassword(
            exception: null,
            hasSentEmail: false,
            isLoading: false,
          ),
        );
        final email = event.email;
        if (email == null) {
          return; // user just wants to go to forgot-password screen
        }

        // User wants to actually send a forgot-password email
        emit(
          const AppStateForgotPassword(
            exception: null,
            hasSentEmail: false,
            isLoading: true,
          ),
        );

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

        emit(
          AppStateForgotPassword(
            exception: exception,
            hasSentEmail: didSendEmail,
            isLoading: false,
          ),
        );
      },
    );
    // send email verification
    on<AppEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      },
    );
    on<AppEventRegister>(
      (event, emit) async {
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
          emit(
            AppStateRegistering(
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );
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
          final userInformation = await UserCloudFireStoreService.instance.getUserInformationById(
            userId: AuthService.firebase().currentUser!.id,
          );

          if (userInformation == null) return;

          event.context.read<UserInformationNotifier>().setAllUserInformation(
                userInformation: userInformation,
              );

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
    on<AppEventLogIn>(
      (event, emit) async {
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
                isLoading: true,
              ),
            );
            await UserCloudFireStoreService.instance
                .createUserIfNotExist(userId: AuthService.firebase().currentUser!.id);

            final userInformation = await UserCloudFireStoreService.instance.getUserInformationById(
              userId: AuthService.firebase().currentUser!.id,
            );

            if (userInformation == null) return;

            event.context.read<UserInformationNotifier>().setAllUserInformation(
                  userInformation: userInformation,
                );
            emit(
              AppStateLoggedIn(
                user: user,
                isLoading: false,
              ),
            );
          }
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
    on<AppEventLogInWithGoogle>((event, emit) async {
      const AppStateLoggedOut(
        exception: null,
        isLoading: true,
      );
      try {
        await provider.signInWithGoogle();

        await UserCloudFireStoreService.instance.createUserIfNotExist(userId: AuthService.firebase().currentUser!.id);

        final userInformation = await UserCloudFireStoreService.instance.getUserInformationById(
          userId: AuthService.firebase().currentUser!.id,
        );

        if (userInformation == null) return;

        event.context.read<UserInformationNotifier>().setAllUserInformation(
              userInformation: userInformation,
            );

        emit(
          AppStateLoggedIn(
            user: AuthService.firebase().currentUser!,
            isLoading: false,
          ),
        );
      } catch (_) {
        emit(
          const AppStateLoggedOut(
            exception: null,
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
          event.context.read<UserInformationNotifier>().clearUserInformationsLocal();

          event.context.read<SaleProductNotifier>().clearSaleProduct();
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
    on<AppEventDeleteAccount>(
      (event, emit) async {
        emit(
          const AppStateDeletedAccount(
            exception: null,
            isLoading: true,
            loadingText: 'Wait a second, we delete your account',
          ),
        );
        final userId = AuthService.firebase().currentUser!.id;

        FirebaseAuth.instance.currentUser!.reauthenticateWithCredential;

        await provider.deleteAccount();

        event.context.read<UserInformationNotifier>().clearUserInformationsLocal();

        event.context.read<SaleProductNotifier>().clearSaleProduct();

        ProductCloudFireStoreService.instance.removeAllProductsById(
          userId: userId,
        );

        UserCloudFireStoreService.instance.deleteUserById(
          userId: userId,
        );

        emit(
          const AppStateDeletedAccount(
            exception: null,
            isLoading: false,
          ),
        );
      },
    );
  }
}
