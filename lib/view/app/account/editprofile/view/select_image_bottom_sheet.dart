import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_hand/product/utilities/image_pick/image_picker_manager.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';

extension SelectImageFrom on SelectPhotoFromBottomSheet {
  // --> from https://vbacik-10.medium.com/season-two-flutter-short-but-golds-8cff8f4b0b29
  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(context: context, builder: (context) => this);
  }
}

class SelectPhotoFromBottomSheet extends StatelessWidget {
  const SelectPhotoFromBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: Text(context.loc.fromCamera),
          onTap: () async {
            final XFile? selectedImage =
                await ImagePickerManager.instance.pickSingleImage(imageSource: ImageSource.camera);

            if (selectedImage == null) return;

            final photo = File(selectedImage.path);
            Navigator.pop<File?>(context, photo);
          },
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: Text(context.loc.fromGallery),
          onTap: () async {
            final XFile? selectedImage =
                await ImagePickerManager.instance.pickSingleImage(imageSource: ImageSource.gallery);

            if (selectedImage == null) return;

            final photo = File(selectedImage.path);

            Navigator.pop<File?>(context, photo);
          },
        ),
        const ListTile(),
      ],
    );
  }
}
