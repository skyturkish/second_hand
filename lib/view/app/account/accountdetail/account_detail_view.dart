import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/view/_product/_widgets/circleavatar/profile_photo.dart';

class AccountDetailView extends StatelessWidget {
  const AccountDetailView({Key? key, this.photo}) : super(key: key);

  final Uint8List? photo;

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserInformationNotifier>().userInformation;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account detail'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ProfilePhotoCircle(photo: photo, defaultAssetsPath: 'assets/images/dog_eats_bread.jpg'),
              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: const [Text('0'), Text('Following')],
                      ),
                      Column(
                        children: const [Text('0'), Text('Follower')],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ],
          ),
          Text(
            user.name,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            user.aboutYou,
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
