import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/theme_notifer.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/service/auth/bloc/app_bloc.dart';
import 'package:second_hand/service/auth/bloc/app_event.dart';
import 'package:second_hand/utilities/dialogs/logout_dialog.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          OptionListTile(
            titleText: 'Pricavy',
            subTitleText: 'Phone number visibility',
            onTap: () {
              // context.read<UserInformationNotifier>().userInformation.favoriteAds.log();
            },
          ),
          OptionListTile(
            titleText: 'Notifications',
            subTitleText: 'Recommendations & Special communications',
            onTap: () {
              print(context.read<UserInformationNotifier>().userInformation.favoriteAds);
              //context.read<UserInformationNotifier>().userInformation.name.log();
            },
          ),
          OptionListTile(
            titleText: 'Logout',
            onTap: () async {
              final logout = await showLogOutDialog(context);
              if (logout) {
                Navigator.of(context).pop();
                context.read<AppBloc>().add(
                      const AppEventLogOut(),
                    );
              }
            },
          ),
          OptionListTile(
            titleText: 'Delete account',
            onTap: () async {
              Navigator.of(context).pop();

              context.read<AppBloc>().add(
                    const AppEventDeleteAccount(),
                  );
            },
          ),
          OptionListTile(
            titleText: 'Dark/Light',
            onTap: () {
              context.read<ThemeNotifier>().changeTheme();
            },
          ),
        ],
      ),
    );
  }
}
