import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/_product/_widgets/circleavatar/profile_photo.dart';
import 'package:second_hand/view/_product/_widgets/grid_view/product_grid_view.dart';
import 'package:second_hand/view/app/account/editprofile/edit_profie_view.dart';

class AccountDetailView extends StatefulWidget {
  const AccountDetailView({super.key, required this.user});
  final UserInformation user;

  @override
  State<AccountDetailView> createState() => _AccountDetailViewState();
}

class _AccountDetailViewState extends State<AccountDetailView> {
  late final bool isHost;

  @override
  void initState() {
    isHost = widget.user.userId == context.read<UserInformationNotifier>().userInformation.userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localUser = context.watch<UserInformationNotifier>().userInformation;
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
              ProfilePhotoCircle(userInformation: widget.user),
              Column(
                children: [
                  Row(
                    children: [
                      FollowInformationColumn(
                        count: isHost ? localUser.following.length : widget.user.following.length,
                        countName: 'Following',
                      ),
                      FollowInformationColumn(
                        count: isHost ? localUser.followers.length : widget.user.followers.length,
                        countName: 'Follower',
                      ),
                    ],
                  ),
                  isHost
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EditProfileView(),
                              ),
                            );
                          },
                          child: const Text('Edit Profile'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            //TODO follow
                          },
                          child: const Text('Follow'),
                        ),
                ],
              ),
              const SizedBox.shrink(),
            ],
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              (isHost ? localUser : widget.user).name.overFlowString(limit: 24),
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              (isHost ? localUser : widget.user).aboutYou,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          isHost
              ? const Text('data')
              : Expanded(
                  child: RefreshsableProductGridView(
                    getProducts: ProductCloudFireStoreService.instance.getAllBelongProductsById,
                    userId: widget.user.userId,
                  ),
                ),
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
