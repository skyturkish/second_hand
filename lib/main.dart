import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/app/app_constants.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/core/init/cache/locale_manager.dart';
import 'package:second_hand/core/init/main_build/main_build.dart';
import 'package:second_hand/core/init/navigation/navigation_route.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/provider_list.dart';
import 'package:second_hand/core/init/notifier/theme_notifer.dart';
import 'package:second_hand/firebase_options.dart';
import 'package:second_hand/loading/loading_screen.dart';
import 'package:second_hand/services/auth/bloc/app_bloc.dart';
import 'package:second_hand/services/auth/bloc/app_event.dart';
import 'package:second_hand/services/auth/bloc/app_state.dart';
import 'package:second_hand/view/_product/_widgets/animation/lottie_animation_view.dart';
import 'package:second_hand/view/app/bottom_navigation_view.dart';
import 'package:second_hand/view/authenticate/forgotpassword/view/forgot_password_view.dart';
import 'package:second_hand/view/authenticate/login/view/login_view.dart';
import 'package:second_hand/view/authenticate/register/view/register_view.dart';
import 'package:second_hand/view/authenticate/verifyemail/verify_email_view.dart';

void main() async {
  await _init();
  runApp(
    MultiProvider(
      providers: [
        ...ApplicationProvider.instance.dependItems,
        ...ApplicationProvider.instance.singleItems,
        ...ApplicationProvider.instance.uiChangesItems,
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _init() async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocaleManager.preferencesInit();
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ThemeNotifier>().initTheme();
    return MaterialApp(
      builder: MainBuild.build,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: context.watch<ThemeNotifier>().currentTheme,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: ApplicationConstants.APPLICATION_TITLE,
      home: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(AppEventInitialize(context));
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? context.loc.pleaseWait,
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AppStateLoggedIn) {
          return const BottomNavigationView();
        } else if (state is AppStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AppStateLoggedOut || state is AppStateDeletedAccount) {
          return const LoginView();
        } else if (state is AppStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AppStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: Center(
              child: LottieAnimationView(
                animation: LottieAnimation.splash,
              ),
            ),
          );
        }
      },
    );
  }
}
