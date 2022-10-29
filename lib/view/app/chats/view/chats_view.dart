import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/buildcontext/context_extension.dart';
import 'package:second_hand/core/extensions/buildcontext/loc.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/view/_product/enums/chat_contact_type_enum.dart';
import '../../../_product/_widgets/row/chat_contact_information.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => ChatsViewState();
}

class ChatsViewState extends State<ChatsView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: ChatContactType.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ChatContactType.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.myChats),
          bottom: _myTabView(),
        ),
        body: _tabbarView(),
      ),
    );
  }

  TabBar _myTabView() {
    return TabBar(
      indicatorColor: context.colors.primary,
      padding: EdgeInsets.zero,
      onTap: (int index) {},
      controller: _tabController,
      tabs: ChatContactType.values.map((e) => Tab(text: e.name)).toList(),
    );
  }

  TabBarView _tabbarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: [
        ChatContactInformation(
          userId: AuthService.firebase().currentUser!.id,
          chatContactType: ChatContactType.SELL,
        ),
        ChatContactInformation(
          userId: AuthService.firebase().currentUser!.id,
          chatContactType: ChatContactType.BUY,
        ),
      ],
    );
  }
}
