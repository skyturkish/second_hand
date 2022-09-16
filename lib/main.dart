import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand/core/constants/app/app_constants.dart';
import 'package:second_hand/core/init/localization/language_manager.dart';
import 'package:second_hand/firebase_options.dart';
import 'package:second_hand/loading/loading_screen.dart';
import 'package:second_hand/service/auth/firebase_auth_provider.dart';
import 'package:second_hand/service/bloc/app_bloc.dart';
import 'package:second_hand/service/bloc/app_event.dart';
import 'package:second_hand/service/bloc/app_state.dart';
import 'package:second_hand/view/forgot_password_view.dart';
import 'package:second_hand/view/login_view.dart';
import 'package:second_hand/view/register_view.dart';
import 'package:second_hand/view/verify_email_view.dart';

void main() async {
  await _init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc(
            FirebaseAuthProvider(),
          ),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.TRANSLATIONS_ASSET_PATH,
        startLocale: LanguageManager.instance.enLocale,
        child: const MyApp(),
      ),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(const AppEventInitialize());

    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AppStateLoggedIn) {
          return const Text('data'); // uygulmaya giriş
        } else if (state is AppStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AppStateLoggedOut) {
          return const LoginView();
        } else if (state is AppStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AppStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
