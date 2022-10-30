import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';
import 'package:second_hand/product/utilities/dialogs/keep_same_product.dart';
import 'package:second_hand/view/app/account/account_view.dart';
import 'package:second_hand/view/app/chats/view/chats_view.dart';
import 'package:second_hand/view/app/home/home_view.dart';
import 'package:second_hand/view/app/my_ads/product_tabbar.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          HomeView(),
          ChatsView(),
          SizedBox.shrink(),
          ProductsTabBar(),
          AccountView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.loc.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: context.loc.chats,
          ),
          BottomNavigationBarItem(
            icon: const SizedBox.shrink(),
            label: context.loc.sell,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: context.loc.myProducts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: context.loc.account,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final isProcess = context.read<SaleProductNotifier>().productInProcess();
          if (isProcess) {
            final isKeep = await keepSameProduct(context);
            if (!isKeep) {
              context.read<SaleProductNotifier>().clearSaleProduct();
            }
          }
          await NavigationService.instance.navigateToPage(path: NavigationConstants.INCLUDE_SOME_DETAILS);
        },
        child: const Icon(
          Icons.camera_alt,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
