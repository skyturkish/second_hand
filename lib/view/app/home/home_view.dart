import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/view/_product/_widgets/grid_view/refreshable_product_grid_view.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: context.paddingAllSmall / 2,
          child: Column(
            children: [
              Padding(
                padding: context.paddingOnlyTopSmall,
                child: Row(
                  children: const [
                    Icon(
                      Icons.location_city,
                    ),
                    Text('  Manchester, UK'),
                  ],
                ),
              ),
              Padding(
                padding: context.paddingOnlyTopSmall,
                child:
                    CustomTextFormField(controller: _searchController, labelText: 'search for books, cars, and more'),
              ),
              Padding(
                padding: context.paddingOnlyTopSmall,
                child: Row(
                  children: [
                    Text(
                      'products around you',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: context.paddingOnlyTopSmall,
                  child: RefreshsableProductGridView(
                    getProducts: ProductCloudFireStoreService.instance.getAllNotBelongProducts,
                    userId: AuthService.firebase().currentUser!.id,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
