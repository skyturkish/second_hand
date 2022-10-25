import 'package:flutter/material.dart';
import 'package:second_hand/view/app/my_ads/subview/favorite_view.dart';
import 'package:second_hand/view/app/my_ads/subview/products_view.dart';

class ProductsTabBar extends StatefulWidget {
  const ProductsTabBar({super.key});

  @override
  State<ProductsTabBar> createState() => ProductsTabBarState();
}

class ProductsTabBarState extends State<ProductsTabBar> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _MyTabViews.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _MyTabViews.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Products'),
          bottom: _myTabView(),
        ),
        body: _tabbarView(),
      ),
    );
  }

  TabBar _myTabView() {
    return TabBar(
      indicatorColor: Theme.of(context).colorScheme.secondary,
      padding: EdgeInsets.zero,
      onTap: (int index) {},
      controller: _tabController,
      tabs: _MyTabViews.values.map((e) => Tab(text: e.name)).toList(),
    );
  }

  TabBarView _tabbarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: const [
        MyProductsView(),
        FavoritesView(),
      ],
    );
  }
}

// ignore: constant_identifier_names
enum _MyTabViews { Products, FAVOURITES }
