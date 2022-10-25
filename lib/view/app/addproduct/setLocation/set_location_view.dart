import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/product/utilities/location/location_manager.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/view/_product/_widgets/button/custom_elevated_button.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';

class SetLocationView extends StatefulWidget {
  const SetLocationView({super.key});

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Location',
          ),
        ),
        body: Padding(
          padding: context.paddingAllMedium,
          child: Column(
            children: [
              FutureBuilder(
                future: LocationManager.instance.getCurrentPositionInformations(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Text('Loading....');
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final placeMark = snapshot.data as Placemark;
                        return Card(
                          child: ListTile(
                            title: const Text('Location'),
                            subtitle: Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                ),
                                Text('${placeMark.country} ${placeMark.administrativeArea}'),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.arrow_right,
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
              const Spacer(),
              CustomElevatedButton(
                  onPressed: () async {
                    final saleProductProvider = context.read<SaleProductNotifier>();
                    saleProductProvider.updateProduct(
                      productSellState: 'Sell',
                      locateCountry: 'Turkey',
                      locateCity: 'Izmir',
                    );

                    await ProductCloudFireStoreService.instance.createProduct(
                      product: saleProductProvider.localProduct!,
                      images: saleProductProvider.images,
                    );

                    saleProductProvider.clearSaleProduct();

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Release Product'))
            ],
          ),
        ),
      ),
    );
  }
}
