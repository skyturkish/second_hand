import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:second_hand/firebase_options.dart';
import 'package:second_hand/view/auth/auth_view.dart';

void main() async {
  await _init();
  runApp(
    const MyApp(),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: AuthView(),
    );
  }
}
