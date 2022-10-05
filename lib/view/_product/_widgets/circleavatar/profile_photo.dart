import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfilePhotoCircle extends StatelessWidget {
  const ProfilePhotoCircle({
    Key? key,
    required this.photo,
    required this.defaultAssetsPath,
  }) : super(key: key);

  final Uint8List? photo;
  final String defaultAssetsPath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 70,
      child: CircleAvatar(
        radius: 60,
        backgroundImage: photo == null ? AssetImage(defaultAssetsPath) : MemoryImage(photo!) as ImageProvider,
      ),
    );
  }
}
