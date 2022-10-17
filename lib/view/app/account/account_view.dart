import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => AccountViewState();
}

class AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const UserInformationCard(),
            Padding(
              padding: context.paddingOnlyTopSmall / 2,
              child: OptionListTile(
                titleText: 'Settings',
                leadingIcon: Icons.settings,
                subTitleText: 'Privacy and logout',
                onTap: () {
                  NavigationService.instance.navigateToPage(path: NavigationConstants.SETTINGS_VIEW);
                },
              ),
            ),
            Padding(
              padding: context.paddingOnlyTopSmall / 2,
              child: OptionListTile(
                titleText: 'Help & Support',
                leadingIcon: Icons.support_agent_outlined,
                subTitleText: 'Help center and legal terms',
                onTap: () {
                  NavigationService.instance.navigateToPage(path: NavigationConstants.HELP_AND_SUPPORT);
                },
              ),
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
  });

  @override
  State<UserInformationCard> createState() => _UserInformationCardState();
}

class _UserInformationCardState extends State<UserInformationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.instance.navigateToPage(
          path: NavigationConstants.ACCOUNT_DETAIL,
          data: context.read<UserInformationNotifier>().userInformation,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              context.watch<UserInformationNotifier>().userInformation.profilePhotoPath,
            ),
          ),
          Padding(
            padding: context.paddingOnlyLeftSmallX,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.watch<UserInformationNotifier>().userInformation.name.overFlowString(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Show profile and edit',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error,
                        decoration: TextDecoration.underline,
                      ),
                ),
                const SizedBox.shrink(),
              ],
            ),
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}
