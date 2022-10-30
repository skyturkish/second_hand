import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/app/app_constants.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/core/extensions/string/string_extension.dart';
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
          children: const [
            UserInformationCard(),
            SettingsListTile(),
            HelpAndSupportListTile(),
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
              context.watch<UserInformationNotifier>().userInformation?.profilePhotoPath ??
                  ApplicationConstants.DEFAULT_IMAGE,
            ),
          ),
          Padding(
            padding: context.paddingOnlyLeftSmallX,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.watch<UserInformationNotifier>().userInformation!.name.overFlowString(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  context.loc.showProfileAndEdit,
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

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall / 2,
      child: OptionListTile(
        titleText: context.loc.settings,
        leadingIcon: Icons.settings,
        subTitleText: context.loc.privacyAndLogout,
        onTap: () {
          NavigationService.instance.navigateToPage(path: NavigationConstants.SETTINGS_VIEW);
        },
      ),
    );
  }
}

class HelpAndSupportListTile extends StatelessWidget {
  const HelpAndSupportListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall / 2,
      child: OptionListTile(
        titleText: context.loc.helpAndSupport,
        leadingIcon: Icons.support_agent_outlined,
        subTitleText: context.loc.helpCenter,
        onTap: () {
          NavigationService.instance.navigateToPage(path: NavigationConstants.HELP_AND_SUPPORT);
        },
      ),
    );
  }
}
