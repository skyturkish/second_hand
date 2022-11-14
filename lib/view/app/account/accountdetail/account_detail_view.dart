import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/string/string_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/user_information/user_information.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';
import 'package:second_hand/view/_product/_widgets/button/custom_elevated_button.dart';
import 'package:second_hand/view/_product/_widgets/grid_view/refreshable_product_grid_view.dart';
import 'package:second_hand/view/app/account/editprofile/viewmodel/edit_profile_notifier.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';

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
    isLocalUser = widget.user.userId == context.read<UserInformationNotifier>().userInformation!.userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localUser = context.watch<UserInformationNotifier>().userInformation;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.accountDetail),
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
                    (isLocalUser ? localUser : widget.user)!.profilePhotoPath,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FollowInformationColumn(
                        count: (isLocalUser ? localUser : widget.user)!.followers.length,
                        countName: context.loc.follower,
                        userInformation: widget.user,
                      ),
                      FollowInformationColumn(
                        count: (isLocalUser ? localUser : widget.user)!.following.length,
                        countName: context.loc.following,
                        userInformation: widget.user,
                      ),
                    ],
                  ),
                  if (isLocalUser)
                    CustomElevatedButton(
                      dynamicWidth: 0.42,
                      borderRadius: 30,
                      onPressed: () {
                        final user = context.read<UserInformationNotifier>().userInformation!;

                        context
                            .read<EditProfileNotifier>()
                            .setEditProfileInformations(setName: user.name, setAboutYou: user.aboutYou);

                        NavigationService.instance.navigateToPage(
                          path: NavigationConstants.EDIT_PROFILE,
                        );
                      },
                      child: Text(context.loc.editProfile),
                    )
                  else
                    FollowButtonView(user: widget.user),
                ],
              ),
              const SizedBox.shrink(),
            ],
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              (isLocalUser ? localUser : widget.user)!.name.overFlowString(limit: 24),
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              (isLocalUser ? localUser : widget.user)!.aboutYou,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          if (isLocalUser)
            const Text('')
          else
            Expanded(
              child: ProductGridView(
                query: ProductCloudFireStoreService.instance.getQueryProductBelongUser(
                  userId: widget.user.userId,
                ),
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
        NavigationService.instance.navigateToPage(
          path: NavigationConstants.NETWORK_VIEW,
          data: userInformation,
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
  const FollowButtonView({super.key, required this.user});
  final UserInformation user;
  @override
  State<FollowButtonView> createState() => _FollowButtonViewState();
}

class _FollowButtonViewState extends State<FollowButtonView> {
  Future<void> breakFollow() async {
    await context.read<UserInformationNotifier>().breakFollowUserLocal(userIdWhichOneWillFollow: widget.user.userId);

    await UserCloudFireStoreService.instance.breakFollowUser(
      userIdWhichOneWillFollow: widget.user.userId,
      followerId: AuthService.firebase().currentUser!.id,
    );
    setState(() {});
  }

  Future<void> follow() async {
    await context.read<UserInformationNotifier>().followUserLocal(userIdWhichOneWillFollow: widget.user.userId);

    await UserCloudFireStoreService.instance.followUser(
      userIdWhichOneWillFollow: widget.user.userId,
      followerId: AuthService.firebase().currentUser!.id,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isFollow = context.watch<UserInformationNotifier>().userInformation!.following.contains(widget.user.userId);
    return CustomElevatedButton(
      dynamicWidth: 0.3,
      onPressed: isFollow ? breakFollow : follow,
      child: Text(isFollow ? context.loc.breakFollow : context.loc.follow),
    );
  }
}
