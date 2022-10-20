import 'package:flutter/material.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';

class HelpAndSupportView extends StatelessWidget {
  const HelpAndSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Support'),
      ),
      body: Column(
        children: [
          OptionListTile(
            titleText: 'Help Center',
            subTitleText: 'You can read our help guide',
            onTap: () {
              // bunu da kullanma klavuzu gibi bir yere götürürümn
            },
          ),
          OptionListTile(
            titleText: 'Rate Us',
            subTitleText: 'If you like our app, we will be happy if you rate us',
            onTap: () {
              // google play yerine götürecem
            },
          ),
          OptionListTile(
            titleText: 'Invite your friends to Second-Hand',
            subTitleText: 'Invite your friends to buy and sell their stuff',
            onTap: () {
              // share_plus
            },
          ),
          OptionListTile(
            titleText: 'Version',
            subTitleText: '1.01.215',
            onTap: () {
              // kendim yazacam
            },
          ),
        ],
      ),
    );
  }
}
