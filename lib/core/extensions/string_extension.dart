class ImageConstants {
  static ImageConstants? _instance;

  static ImageConstants get instance {
    _instance ??= ImageConstants._();
    return _instance!;
  }

  ImageConstants._();

  final String addPhoto = 'add_photo'.toPNG;
  final String dogEatsBread = 'dog_eats_bread'.toJPG;
}

extension _ImageConstantsExtensionPng on String {
  String get toPNG => 'assets/images/$this.png';
}

extension _ImageConstantsExtensionJpg on String {
  String get toJPG => 'assets/images/$this.jph';
}

extension OverFlowString on String {
  String overFlowString({int limit = 15}) {
    return length > limit ? '${substring(0, limit - 1)}...' : this;
  }
}
