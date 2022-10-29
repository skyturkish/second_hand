import 'package:flutter/material.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/options_list_tile.dart';
import 'package:second_hand/core/extensions/buildcontext/loc.dart';

class HelpAndSupportView extends StatelessWidget {
  const HelpAndSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.helpAndSupport),
      ),
      body: Column(
        children: [
          OptionListTile(
            titleText: context.loc.helpCenter,
            subTitleText: context.loc.youCanReadOurHelpGuide,
            onTap: () {},
          ),
          OptionListTile(
            titleText: context.loc.rateUs,
            subTitleText: context.loc.ifYouLikeOurApp,
            onTap: () {},
          ),
          OptionListTile(
            titleText: context.loc.inviteYourFriends,
            subTitleText: context.loc.inviteYourFriendsToBuy,
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
