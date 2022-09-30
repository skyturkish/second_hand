import 'package:flutter/material.dart';
import 'package:second_hand/view/app/my_ads/ads_View.dart';
import 'package:second_hand/view/app/my_ads/favorite_view.dart';

class MyAdsView extends StatefulWidget {
  const MyAdsView({Key? key}) : super(key: key);

  @override
  State<MyAdsView> createState() => MyAdsViewState();
}

class MyAdsViewState extends State<MyAdsView> with TickerProviderStateMixin {
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
          title: const Text('My Ads'),
          bottom: _myTabView(),
        ),
        //    extendBody: true, // kazdığımız yeri Scaffold tekrar doldursun diyoruz
        // bottomNavigationBar: BottomAppBar(child: _myTabView()),
        body: _tabbarView(),
      ),
    );
  }

  TabBar _myTabView() {
    return TabBar(
      indicatorColor: const Color.fromARGB(255, 226, 223, 40), // alttaki çizgini rengi
      //labelColor:  Colors.red,
      // unselectedLabelColor: Colors.green,
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
        AdsView(),
        FavoritesView(),
      ],
    );
  }
}

// ignore: constant_identifier_names
enum _MyTabViews { ADS, FAVOURITES }
