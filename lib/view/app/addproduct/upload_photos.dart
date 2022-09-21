import 'package:flutter/material.dart';

class UploadPhotosView extends StatefulWidget {
  const UploadPhotosView({Key? key}) : super(key: key);

  @override
  State<UploadPhotosView> createState() => UploadPhotosViewState();
}

class UploadPhotosViewState extends State<UploadPhotosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UploadPhotos'),
      ),
      body: const Center(
        child: Text(
          'UploadPhotos',
        ),
      ),
    );
  }
}
