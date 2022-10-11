import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/view/include_some_details_view.dart';
import 'package:second_hand/view/app/addproduct/setprice/set_a_price.dart';
import 'package:second_hand/view/app/addproduct/uploadphotos/upload_photos.dart';
import 'package:second_hand/view/app/home/product_detail_view.dart';

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
      case NavigationConstants.PRODUCT_DETAIL:
        final product = args.arguments as Product;
        return normalNavigate(
            widget: ProductDetailView(
          product: product,
        ));

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Text('page is not found'),
          ), //
        );
    }
  }
}

MaterialPageRoute normalNavigate({required Widget widget, String? pageName}) {
  return MaterialPageRoute(
    builder: (context) => widget,
    //analytciste görülecek olan sayfa ismi için pageName veriyoruz
    settings: RouteSettings(name: pageName),
  );
}

// PageRouteBuilder has more properites  than MaterialPageBuilder
PageRouteBuilder createRoute({required Widget widget}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
