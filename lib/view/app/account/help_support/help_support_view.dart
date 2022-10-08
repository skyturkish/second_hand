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
            onTap: () {},
          ),
          OptionListTile(
            titleText: 'Rate Us',
            subTitleText: 'If you like our app, we will be happy if you rate us',
            onTap: () {},
          ),
          OptionListTile(
            titleText: 'Invite your friends to Second-Hand',
            subTitleText: 'Invite your friends to buy and sell their stuff',
            onTap: () {},
          ),
          OptionListTile(
            titleText: 'Version',
            subTitleText: 'bana okulda 0 0 7 derler',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
