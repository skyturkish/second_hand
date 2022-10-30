import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/core/init/notifier/theme_notifer.dart';
import 'package:second_hand/services/auth/bloc/app_bloc.dart';
import 'package:second_hand/services/auth/bloc/app_event.dart';
import 'package:second_hand/product/utilities/dialogs/logout_dialog.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.settings),
      ),
      body: Column(
        children: [
          OptionListTile(
            titleText: context.loc.notifications,
            subTitleText: context.loc.recommendations,
            onTap: () {},
          ),
          OptionListTile(
            titleText: context.loc.logout,
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
          // OptionListTile(
          //   titleText:  'Delete account --- DİSABLED',
          //   onTap: () async {
          //     final deleteDecision = await showDeleteAccountDialog(context);

          //     if (deleteDecision) {
          //       // son zamanlarda girilmeyi isteyebiliyor bazen hesabın silinmesi için onu handle et
          //       Navigator.of(context).pop();

          //       context.read<AppBloc>().add(
          //             AppEventDeleteAccount(context),
          //           );
          //     }
          //   },
          // ),
          OptionListTile(
            titleText: context.loc.darkLight,
            onTap: () {
              context.read<ThemeNotifier>().changeTheme();
            },
          ),
        ],
      ),
    );
  }
}
