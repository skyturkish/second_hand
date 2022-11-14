import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/string/string_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/user_information/user_information.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/user_information_listtile/shimmer_user_information_listtile.dart';

@immutable
class UserInformationListtile extends StatelessWidget {
  const UserInformationListtile({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserCloudFireStoreService.instance.getUserInformationById(userId: userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userInformation = snapshot.data as UserInformation;

          return InkWell(
            onTap: () {
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.ACCOUNT_DETAIL, data: userInformation);
            },
            child: ListTile(
              leading: Hero(
                tag: 'profilephoto $userId',
                child: CircleAvatar(
                  radius: 40,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      userInformation.profilePhotoPath,
                    ),
                  ),
                ),
              ),
              title: Text(
                userInformation.name.overFlowString(limit: 25),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right_outlined,
              ),
            ),
          );
        } else {
          return const ShimmerUserInformationListTile();
        }
      },
    );
  }
}
