import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

class ImageCompress {
  static final ImageCompress instance = ImageCompress._internal();

  factory ImageCompress() {
    return instance;
  }

  ImageCompress._internal();

  // TODO This don't belong here, to where ?
  Future<File> compressFile(File file) async {
    final compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 50,
    );
    return compressedFile;
  }
}
