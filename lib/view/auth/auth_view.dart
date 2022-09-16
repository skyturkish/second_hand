import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => AuthViewState();
}

class AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Auth',
        style: TextStyle(color: Colors.red),
      )),
    );
  }
}
