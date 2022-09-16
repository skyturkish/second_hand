import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).backgroundColor.toString());
    return const Scaffold(
      body: Center(
        child: Text(
          'Home',
        ),
      ),
    );
  }
}
