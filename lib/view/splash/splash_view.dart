// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:second_hand/core/constants/enums/lottie_animation.dart';
// import 'package:second_hand/core/init/cache/locale_manager.dart';
// import 'package:second_hand/core/init/notifier/theme_notifer.dart';
// import 'package:second_hand/firebase_options.dart';
// import 'package:second_hand/main.dart';
// import 'package:second_hand/view/_product/_widgets/animation/lottie_view.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({Key? key}) : super(key: key);

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   bool isSplashEnd = false;

//   @override
//   void initState() {
//     initApp();
//     super.initState();
//   }

//   Future<void> initApp() async {
//     context.read<ThemeNotifier>().initTheme();

//     WidgetsFlutterBinding.ensureInitialized();
//     await EasyLocalization.ensureInitialized();
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     await LocaleManager.preferencesInit(); // Shared_preferences init
//     isSplashEnd = true;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isSplashEnd == false
//         ? const LottieAnimationView(
//             animation: LottieAnimation.splash,
//           )
//         : const MyApp();
//   }
// }
