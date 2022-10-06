import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';

class ProfilePhotoCircle extends StatelessWidget {
  const ProfilePhotoCircle({
    super.key,
    this.defaultAssetsPath = 'assets/images/dog_eats_bread.jpg',
  });

  final String defaultAssetsPath;

  @override
  Widget build(BuildContext context) {
    final photo = context.watch<UserInformationNotifier>().userPhoto;
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 70,
      child: CircleAvatar(
        radius: 60,
        backgroundImage: photo == null ? AssetImage(defaultAssetsPath) : MemoryImage(photo) as ImageProvider,
      ),
    );
  }
}
