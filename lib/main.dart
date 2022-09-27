import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/app/app_constants.dart';
import 'package:second_hand/core/init/localization/language_manager.dart';
import 'package:second_hand/core/init/navigation/navigation_route.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/firebase_options.dart';
import 'package:second_hand/loading/loading_screen.dart';
import 'package:second_hand/service/auth/bloc/app_bloc.dart';
import 'package:second_hand/service/auth/bloc/app_event.dart';
import 'package:second_hand/service/auth/bloc/app_state.dart';
import 'package:second_hand/service/auth/firebase_auth_provider.dart';
import 'package:second_hand/view/app/bottom_navigation_view.dart';
import 'package:second_hand/view/authenticate/forgot_password_view.dart';
import 'package:second_hand/view/authenticate/login_view.dart';
import 'package:second_hand/view/authenticate/register_view.dart';
import 'package:second_hand/view/authenticate/verify_email_view.dart';

void main() async {
  await _init();
  runApp(
    // TODO providerları başka yere al
    MultiProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc(
            FirebaseAuthProvider(),
          ),
        ),
        ChangeNotifierProvider<ProductNotifier>(
          create: (context) => ProductNotifier.instance,
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
      // TODO theme'leri başka yere al
      theme: ThemeData.light().copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.red,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(color: Colors.black),
          iconColor: Color.fromARGB(255, 14, 13, 13),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 141, 134, 134),
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(
            color: Theme.of(context).errorColor,
          ),
          selectedLabelStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: Theme.of(context).highlightColor,
          ),
          unselectedLabelStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: ApplicationConstants.APPLICATION_TITLE,
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
          return const DenemePhotoView(); // uygulmaya giriş

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

class DenemePhotoView extends StatelessWidget {
  const DenemePhotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: const []),
    );
  }
}
