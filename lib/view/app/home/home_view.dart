import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  File? bursa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final ui = await FirebaseStorage.instance
                .ref('products')
                .child('8f9efb92-769a-474a-a7d9-37f7cebe4fb5')
                .child('ae1a7bcc-8555-468f-a7a8-7d79e2d4a773')
                .getData();
            bursa = File.fromRawPath(ui!);

            setState(() {});
          },
          child: const Text(
            'Home',
          ),
        ),
        bursa == null ? const SizedBox.shrink() : Image.file(bursa!)
      ],
    ));
  }
}
