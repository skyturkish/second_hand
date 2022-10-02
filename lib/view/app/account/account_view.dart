import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/navigation/navigation_route.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';
import 'package:second_hand/view/app/account/settings_view.dart';
import 'package:second_hand/view/app/home/storage_image_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => AccountViewState();
}

class AccountViewState extends State<AccountView> {
  // TODO bu storageRef'i provider'ın içinde tutsan güzel olmaz mı ? sürekli baştan oluşutuyorsun
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    final userInformation = context.read<UserInformationNotifier>().userInformation;
    print(userInformation.userId);
    print(userInformation.userId);
    print(userInformation.userId);
    print(userInformation.userId);
    print(userInformation.userId);
    print(userInformation.userId);
    print(userInformation.userId);
    print(userInformation.userId);
    print(userInformation.userId);
    final mountainImagesRef = storageRef.child('users/${userInformation.userId}/kedi_fotografi.jpg');

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: userInformation.profilePhotoPath != ''
                      ? const Icon(Icons.account_circle_rounded)
                      : StorageImageView(
                          image: mountainImagesRef,
                        ),
                ),
              ],
            ),
            OptionListTile(
              titleText: 'Settings',
              leadingIcon: Icons.settings,
              subTitleText: 'Privacy and logout',
              onTap: () {
                Navigator.of(context).push(
                  createRoute(
                    widget: const SettingsView(),
                  ),
                );
              },
            ),
            OptionListTile(
              titleText: 'Help & Support',
              leadingIcon: Icons.support_agent_outlined,
              subTitleText: 'Help center and legal terms',
              onTap: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
