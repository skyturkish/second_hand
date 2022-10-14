import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/view/app/account/accountdetail/account_detail_view.dart';
import 'package:second_hand/view/app/account/accountdetail/subview/network_view.dart';
import 'package:second_hand/view/app/account/editprofile/view/edit_profie_view.dart';
import 'package:second_hand/view/app/account/help_support/help_support_view.dart';
import 'package:second_hand/view/app/account/settings/settings_view.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/view/include_some_details_view.dart';
import 'package:second_hand/view/app/addproduct/setprice/view/set_a_price_view.dart';
import 'package:second_hand/view/app/addproduct/uploadphotos/upload_photos.dart';
import 'package:second_hand/view/app/chats/subview/chat_view.dart';
import 'package:second_hand/view/app/home/subview/product_detail_view.dart';

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
          ),
        );
      case NavigationConstants.SETTINGS_VIEW:
        return createRoute(widget: const SettingsView());

      case NavigationConstants.HELP_AND_SUPPORT:
        return createRoute(widget: const HelpAndSupportView());
      case NavigationConstants.EDIT_PROFILE:
        return normalNavigate(widget: const EditProfileView());

      case NavigationConstants.NETWORK_VIEW:
        final userInformation = args.arguments as UserInformation;
        return normalNavigate(widget: NetworkView(userInformation: userInformation));

      case NavigationConstants.ACCOUNT_DETAIL:
        final userInformation = args.arguments as UserInformation;
        return normalNavigate(
          widget: AccountDetailView(user: userInformation),
        );

      case NavigationConstants.CHAT_VIEW:
        final arguments = args.arguments as List;
        final productId = arguments[0] as String;
        final contactUserId = arguments[1] as String;

        return createRoute(widget: ChatView(productId: productId, contactUserId: contactUserId));

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
