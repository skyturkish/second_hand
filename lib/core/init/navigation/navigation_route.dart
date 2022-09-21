import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/view/app/addproduct/include_some_details.dart';
import 'package:second_hand/view/app/addproduct/set_a_price.dart';
import 'package:second_hand/view/app/addproduct/upload_photos.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.INCLUDE_SOME_DETAILS:
        return normalNavigate(widget: const IncludeSomeDetailsView());

      case NavigationConstants.SET_A_PRICE:
        return normalNavigate(widget: const SetAPriceView());

      case NavigationConstants.UPLOAD_PHOTOS:
        return normalNavigate(widget: const UploadPhotosView());

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
