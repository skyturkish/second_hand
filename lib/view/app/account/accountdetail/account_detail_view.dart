import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product_service.dart';
import 'package:second_hand/view/_product/_widgets/grid_view/refreshable_product_grid_view.dart';
import 'package:second_hand/view/app/account/accountdetail/subview/network_view.dart';
import 'package:second_hand/view/app/account/editprofile/view/edit_profie_view.dart';

class AccountDetailView extends StatefulWidget {
  const AccountDetailView({super.key, required this.user});
  final UserInformation user;

  @override
  State<AccountDetailView> createState() => _AccountDetailViewState();
}

class _AccountDetailViewState extends State<AccountDetailView> {
  late final bool isLocalUser;

  @override
  void initState() {
    isLocalUser = widget.user.userId == context.read<UserInformationNotifier>().userInformation.userId;
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
              Hero(
                tag: 'profilephoto ${widget.user.userId}',
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    widget.user.profilePhotoPath,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      FollowInformationColumn(
                        count: (isLocalUser ? localUser : widget.user).followers.length,
                        countName: 'Follower',
                        userInformation: widget.user,
                      ),
                      FollowInformationColumn(
                        count: (isLocalUser ? localUser : widget.user).following.length,
                        countName: 'Following',
                        userInformation: widget.user,
                      ),
                    ],
                  ),
                  isLocalUser
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
                      : FollowButtonView(user: widget.user),
                ],
              ),
              const SizedBox.shrink(),
            ],
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              (isLocalUser ? localUser : widget.user).name.overFlowString(limit: 24),
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              (isLocalUser ? localUser : widget.user).aboutYou,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          isLocalUser
              ? const Text('data')
              : Expanded(
                  child: RefreshsableProductGridView(
                    getProducts: ProductCloudFireStoreService.instance.getAllBelongProducts,
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
    required this.userInformation,
  });
  final int count;
  final String countName;
  final UserInformation userInformation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NetworkView(userInformation: userInformation),
          ),
        );
      },
      child: Column(
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
      ),
    );
  }
}

class FollowButtonView extends StatefulWidget {
  const FollowButtonView({Key? key, required this.user}) : super(key: key);
  final UserInformation user;
  @override
  State<FollowButtonView> createState() => _FollowButtonViewState();
}

class _FollowButtonViewState extends State<FollowButtonView> {
  void breakFollow() {
    context.read<UserInformationNotifier>().breakFollowUserBothFirebaseAndLocal(
        userIdWhichOneWillFollow: widget.user.userId, followerId: AuthService.firebase().currentUser!.id);
    setState(() {});
  }

  void follow() {
    context.read<UserInformationNotifier>().followUserBothFirebaseAndLocal(
        userIdWhichOneWillFollow: widget.user.userId, followerId: AuthService.firebase().currentUser!.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFollow = context.watch<UserInformationNotifier>().userInformation.following.contains(widget.user.userId);
    return ElevatedButton(
      onPressed: isFollow ? breakFollow : follow,
      child: Text(isFollow ? 'Break Follow' : 'Follow'),
    );
  }
}
