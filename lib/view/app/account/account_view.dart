import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_route.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/view/_product/_widgets/circleavatar/profile_photo.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';
import 'package:second_hand/view/app/account/accountdetail/account_detail_view.dart';
import 'package:second_hand/view/app/account/settings/settings_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => AccountViewState();
}

class AccountViewState extends State<AccountView> {
  // TODO bu storageRef'i provider'ın içinde tutsan güzel olmaz mı ? sürekli baştan oluşutuyorsun
  final storageRef = FirebaseStorage.instance.ref();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            UserInformationCard(
              user: context.read<UserInformationNotifier>().userInformation,
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

class UserInformationCard extends StatefulWidget {
  const UserInformationCard({
    super.key,
    required this.user,
  });
  final UserInformation user;

  @override
  State<UserInformationCard> createState() => _UserInformationCardState();
}

class _UserInformationCardState extends State<UserInformationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AccountDetailView(),
          ),
        );
      },
      child: Row(
        children: [
          const ProfilePhotoCircle(),
          Padding(
            padding: context.paddingOnlyLeftSmallX,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name.overFlowString(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Show profile and edit',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                ),
                const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
