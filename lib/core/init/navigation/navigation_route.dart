import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/view/app/add_product.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.ADD_PRODUCT_VIEW:
        return normalNavigate(widget: const AddProductView());

      // case NavigationConstants.TEST_VIEW:
      //   return normalNavigate(TestsView(), NavigationConstants.TEST_VIEW);

      // case NavigationConstants.BUY_VIEW:
      //   return normalNavigate(BuyView(), NavigationConstants.BUY_VIEW);

      // case NavigationConstants.ON_BOARD:
      //   return normalNavigate(OnBoardView(), NavigationConstants.ON_BOARD);

      // case NavigationConstants.SETTINGS_WEB_VIEW:
      //   if (args.arguments is SettingsDynamicModel) {
      //     return normalNavigate(
      //       SettingsDynamicView(model: args.arguments as SettingsDynamicModel),
      //       NavigationConstants.SETTINGS_WEB_VIEW,
      //     );
      //   }
      //   throw NavigateException<SettingsDynamicModel>(args.arguments);

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Text('page is not found'),
          ),
        );
    }
  }

  MaterialPageRoute normalNavigate({required Widget widget, String? pageName}) {
    return MaterialPageRoute(
      builder: (context) => widget,
      //analytciste görülecek olan sayfa ismi için pageName veriyoruz
      settings: RouteSettings(name: pageName),
    );
  }
}
