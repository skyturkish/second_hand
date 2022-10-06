import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/user.dart';

class ProfilePhotoCircle extends StatefulWidget {
  const ProfilePhotoCircle({
    super.key,
    required this.userInformation,
    this.radius = 45,
  });

  final UserInformation userInformation;
  final double radius;

  @override
  State<ProfilePhotoCircle> createState() => _ProfilePhotoCircleState();
}

class _ProfilePhotoCircleState extends State<ProfilePhotoCircle> {
  late final bool isLocalUser;

  Uint8List? photo;
  @override
  void initState() {
    isLocalUser = widget.userInformation.userId == context.read<UserInformationNotifier>().userInformation.userId;
    if (isLocalUser) return;
    getImage();
    super.initState();
  }

  Future<void> getImage() async {
    photo = await FirebaseStorage.instance.ref().child(widget.userInformation.profilePhotoPath).getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius + ((widget.radius / 100) * 12),
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage:
            // TODO buraya gerçekten geç geldiği zaman karşıdakinin geç geleceğini anladığın bir fotoğraf koyarsın
            // TODO he anasını satim, naptım burada
            // çalışması önemli falan değil kötü gözüküyor kimse okuyamaz bunu, burayı düzelt
            isLocalUser
                ? context.read<UserInformationNotifier>().userPhoto != null
                    ? MemoryImage(context.watch<UserInformationNotifier>().userPhoto!) as ImageProvider
                    : const AssetImage('assets/images/dog_eats_bread.jpg')
                : (photo == null
                    ? const AssetImage('assets/images/dog_eats_bread.jpg')
                    : MemoryImage(photo!) as ImageProvider),
      ),
    );
  }
}
