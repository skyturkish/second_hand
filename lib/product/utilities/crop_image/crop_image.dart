import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';

class CropImage {
  static final CropImage instance = CropImage._internal();

  factory CropImage() {
    return instance;
  }

  CropImage._internal();
  Future<CroppedFile?> croppedFile({required BuildContext context, required String imageFilePath}) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFilePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: context.colors.primary,
          toolbarWidgetColor: context.colors.onPrimary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return croppedFile;
  }
}
