import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/view/_product/_widgets/circleavatar/profile_photo.dart';
import 'package:second_hand/view/app/account/editprofile/edit_profie_view.dart';

class AccountDetailView extends StatelessWidget {
  const AccountDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserInformationNotifier>().userInformation;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const ProfilePhotoCircle(),
              Column(
                children: [
                  Row(
                    children: const [
                      FollowInformationColumn(
                        count: 0,
                        countName: 'Following',
                      ),
                      FollowInformationColumn(
                        count: 0,
                        countName: 'Follower',
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const EditProfileView(),
                        ),
                      );
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
              const SizedBox.shrink(),
            ],
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              user.name.overFlowString(limit: 24),
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              user.aboutYou,
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        ],
      ),
    );
  }
}

class FollowInformationColumn extends StatelessWidget {
  const FollowInformationColumn({
    super.key,
    required this.count,
    required this.countName,
  });
  final int count;
  final String countName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: context.paddingOnlyTopSmall,
          child: Text(
            countName,
            style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
