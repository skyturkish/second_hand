import 'package:image_picker/image_picker.dart';

class ImagePickerManager {
  static final ImagePickerManager instance = ImagePickerManager._internal();

  factory ImagePickerManager() {
    return instance;
  }

  ImagePickerManager._internal();

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickSingleImage({required ImageSource imageSource}) async {
    final xFileimage = await _picker.pickImage(
      source: imageSource,
      imageQuality: 50,
    );

    return xFileimage;
  }

  Future<List<XFile>?> pickMultiImage() async {
    final xFileimages = await _picker.pickMultiImage(
      maxHeight: 1024,
      maxWidth: 1024,
      imageQuality: 50,
    );

    return xFileimages;
  }
}
