import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/models/user_information.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/user_information_listtile/user_information_listtile.dart';
import 'package:second_hand/view/_product/enums/follow_type.dart';

// TODO burada direkt bool değer al, follow mu followers mı diye hatta enum al direkt
class FollowInformationsView extends StatefulWidget {
  const FollowInformationsView({Key? key, required this.followType, required this.userInformation}) : super(key: key);
  final FollowType followType;
  final UserInformation userInformation;
  @override
  State<FollowInformationsView> createState() => _FollowInformationsViewState();
}

class _FollowInformationsViewState extends State<FollowInformationsView> {
  List<String>? users;

  @override
  void initState() {
    getAllUsers();
  }

  void getAllUsers() {
    switch (widget.followType) {
      case FollowType.FOLLOWING:
        users = widget.userInformation.followers;
        break;
      case FollowType.FOLLOW:
        users = widget.userInformation.following;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: context.paddingOnlyTopSmall,
          child: UserInformationListtile(
            userId: users![index],
          ),
        );
      },
    );
  }
}
