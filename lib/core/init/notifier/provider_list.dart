import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/theme_notifer.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/services/auth/bloc/app_bloc.dart';
import 'package:second_hand/services/auth/firebase_auth_provider.dart';
import 'package:second_hand/view/app/account/editprofile/viewmodel/edit_profile_notifier.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';
import 'package:second_hand/view/app/home/subview/product_detail_view_model.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;

  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();

    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [
    ChangeNotifierProvider<SaleProductNotifier>(
      create: (context) => SaleProductNotifier(),
    ),
    ChangeNotifierProvider<UserInformationNotifier>(
      create: (context) => UserInformationNotifier(),
    ),
  ];
  List<SingleChildWidget> dependItems = [
    Provider.value(
      value: NavigationService.instance,
    ),
    BlocProvider<AppBloc>(
      create: (context) => AppBloc(
        FirebaseAuthProvider(),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    ),
  ];
  List<SingleChildWidget> uiChangesItems = [
    ChangeNotifierProvider<EditProfileNotifier>(
      create: (context) => EditProfileNotifier(),
    ),
    ChangeNotifierProvider<ProductDetailViewModelNotifier>(
      create: (context) => ProductDetailViewModelNotifier(),
    ),
  ];
}
