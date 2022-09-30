import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/view/app/account/account_view.dart';
import 'package:second_hand/view/app/chats/chats_view.dart';
import 'package:second_hand/view/app/home/home_view.dart';
import 'package:second_hand/view/app/my_ads/my_ads_view.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  State<BottomNavigationView> createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends State<BottomNavigationView> {
// TODO bunun serviste olması lazım aslında

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          HomeView(),
          ChatsView(),
          SizedBox.shrink(),
          MyAdsView(),
          AccountView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          NavigationService.instance.navigateToPage(path: NavigationConstants.INCLUDE_SOME_DETAILS);
        },
        child: const Icon(
          Icons.camera_alt,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'My Ads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
