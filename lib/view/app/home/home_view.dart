import 'package:flutter/material.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/_product/_widgets/grid_view/refreshable_product_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshsableProductGridView(
            getProducts: ProductCloudFireStoreService.instance.getAllNotBelongProducts,
            userId: AuthService.firebase().currentUser!.id));
  }
}
