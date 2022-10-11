import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/utilities/dialogs/keep_same_product.dart';
import 'package:second_hand/view/app/account/account_view.dart';
import 'package:second_hand/view/app/chats/chats_view.dart';
import 'package:second_hand/view/app/home/home_view.dart';
import 'package:second_hand/view/app/my_ads/my_products_view.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends State<BottomNavigationView> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInformation();
  }

  Future<void> getUserInformation() async {
    await context.read<UserInformationNotifier>().getUserInformation(userId: AuthService.firebase().currentUser!.id);
    setState(() {});
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
          MyProductsView(),
          AccountView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isProcess = context.read<ProductNotifier>().productInProcess();
          if (isProcess) {
            final isKeep = await keepSameProduct(context);
            if (!isKeep) {
              context.read<ProductNotifier>().clearProduct();
            }
          }
          await NavigationService.instance.navigateToPage(path: NavigationConstants.INCLUDE_SOME_DETAILS);
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
            label: 'My Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
