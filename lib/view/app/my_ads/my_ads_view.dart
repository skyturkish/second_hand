import 'package:flutter/material.dart';

class MyAdsView extends StatefulWidget {
  const MyAdsView({Key? key}) : super(key: key);

  @override
  State<MyAdsView> createState() => MyAdsViewState();
}

class MyAdsViewState extends State<MyAdsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'MyAds',
        ),
      ),
    );
  }
}
