import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/theme_notifer.dart';
import 'package:second_hand/service/auth/bloc/app_bloc.dart';
import 'package:second_hand/service/auth/bloc/app_event.dart';
import 'package:second_hand/utilities/dialogs/delete_account_dialog.dart';
import 'package:second_hand/utilities/dialogs/logout_dialog.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
            onTap: () {},
          ),
          OptionListTile(
            titleText: 'Notifications',
            subTitleText: 'Recommendations & Special communications',
            onTap: () {},
          ),
          OptionListTile(
            titleText: 'Logout',
            onTap: () async {
              final logoutDecision = await showLogOutDialog(context);
              if (logoutDecision) {
                Navigator.of(context).pop();
                context.read<AppBloc>().add(
                      AppEventLogOut(context),
                    );
              }
            },
          ),
          OptionListTile(
            titleText: 'Delete account',
            onTap: () async {
              final deleteDecision = await showDeleteAccountDialog(context);

              if (deleteDecision) {
                Navigator.of(context).pop();
                // son zamanlarda girilmeyi isteyebiliyor bazen hesabın silinmesi için onu handle et
                context.read<AppBloc>().add(
                      AppEventDeleteAccount(context),
                    );
              }
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
