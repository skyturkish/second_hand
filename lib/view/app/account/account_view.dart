import 'package:flutter/material.dart';
import 'package:second_hand/core/init/navigation/navigation_route.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';
import 'package:second_hand/view/app/account/settings_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => AccountViewState();
}

class AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
            title: Text('Göktürk Acar'),
            subtitle: Text('View and Edit profile'),
          ),
          OptionListTile(
            titleText: 'Settings',
            leadingIcon: Icons.settings,
            subTitleText: 'Privacy and logout',
            onTap: () {
              Navigator.of(context).push(
                createRoute(
                  widget: SettingsView(),
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
    );
  }
}


// ElevatedButton(
//           onPressed: () {
//             context.read<ThemeNotifier>().changeValue();
//           },
//           child: const Text('change theme'),
//         ),