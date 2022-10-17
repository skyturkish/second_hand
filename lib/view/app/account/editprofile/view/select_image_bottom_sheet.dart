import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

extension SelectImageFrom on SelectPhotoFromBottomSheet {
  // --> from https://vbacik-10.medium.com/season-two-flutter-short-but-golds-8cff8f4b0b29
  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(context: context, builder: (context) => this);
  }
}

@immutable
class SelectPhotoFromBottomSheet extends StatelessWidget {
  SelectPhotoFromBottomSheet({Key? key}) : super(key: key);
  late final File? photo;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: const Text('From camera'),
          onTap: () async {
            final XFile? selectedImage = await _picker.pickImage(source: ImageSource.camera);
            photo = File(selectedImage!.path);
            Navigator.pop<File?>(context, photo);
          },
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('From gallery'),
          onTap: () async {
            final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
            photo = File(selectedImage!.path);
            Navigator.pop<File?>(context, photo);
          },
        ),
        const ListTile(),
      ],
    );
  }
}
