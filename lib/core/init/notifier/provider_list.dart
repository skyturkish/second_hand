import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/service/auth/bloc/app_bloc.dart';
import 'package:second_hand/service/auth/firebase_auth_provider.dart';

import 'theme_notifer.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;

  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();

    return _instance!;
  }

  ApplicationProvider._init();

  // TODO tüm providerlar aynı listede mi duracak ?

  List<SingleChildWidget> singleItems = [];
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
    ChangeNotifierProvider<ProductNotifier>(
      create: (context) => ProductNotifier.instance,
    ),
    ChangeNotifierProvider<UserInformationNotifier>(
      create: (context) => UserInformationNotifier.instance,
    ),
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
