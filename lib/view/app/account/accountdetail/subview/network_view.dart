import 'package:flutter/material.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/view/_product/enums/follow_type.dart';
import 'package:second_hand/view/app/account/accountdetail/subview/follow_information_view.dart';

class NetworkView extends StatefulWidget {
  const NetworkView({super.key, required this.userInformation});
  final UserInformation userInformation;
  @override
  State<NetworkView> createState() => NetworkViewState();
}

class NetworkViewState extends State<NetworkView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FollowTypeEnum.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: FollowTypeEnum.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Network'),
          bottom: _myTabView(),
        ),
        body: _tabbarView(),
      ),
    );
  }

  TabBar _myTabView() {
    return TabBar(
      indicatorColor: Theme.of(context).colorScheme.primary,
      padding: EdgeInsets.zero,
      onTap: (int index) {},
      controller: _tabController,
      tabs: FollowTypeEnum.values.map((e) => Tab(text: e.name)).toList(),
    );
  }

  TabBarView _tabbarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        FollowInformationsView(followType: FollowType.FOLLOW, userInformation: widget.userInformation),
        FollowInformationsView(followType: FollowType.FOLLOWING, userInformation: widget.userInformation),
      ],
    );
  }
}

// ignore: constant_identifier_names
enum FollowTypeEnum { FOLLOWING, FOLLOWERS }
