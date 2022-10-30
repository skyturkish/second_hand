import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/view/_product/_widgets/grid_view/refreshable_product_grid_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: context.paddingAllSmall / 2,
          child: Column(
            children: const [
              ProductsText(),
              Expanded(
                child: ProductsGridView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsText extends StatelessWidget {
  const ProductsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: Row(
        children: [
          Text(
            context.loc.products,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: RefreshsableProductGridView(
        getProducts: ProductCloudFireStoreService.instance.getAllNotBelongProducts,
        userId: AuthService.firebase().currentUser!.id,
      ),
    );
  }
}
