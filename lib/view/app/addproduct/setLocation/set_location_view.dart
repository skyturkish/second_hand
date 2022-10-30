import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/product/utilities/location/location_manager.dart';
import 'package:second_hand/services/cloud/product/product_service.dart';
import 'package:second_hand/view/_product/_widgets/animation/lottie_animation_view.dart';
import 'package:second_hand/view/_product/_widgets/button/custom_elevated_button.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';

class SetLocationView extends StatefulWidget {
  const SetLocationView({super.key});

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView> {
  Placemark? placeMark;
  @override
  void initState() {
    getPositionInformations();
    super.initState();
  }

  Future<void> getPositionInformations() async {
    placeMark = await LocationManager.instance.getCurrentPositionInformations();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.loc.location,
          ),
        ),
        body: Padding(
          padding: context.paddingAllMedium,
          child: placeMark == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.loc.weAreTryingToFind,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: const Color.fromARGB(255, 67, 117, 167),
                          ),
                    ),
                    const LottieAnimationView(
                      animation: LottieAnimation.location,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          context.loc.location,
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(
                              Icons.location_city,
                            ),
                            Text('${placeMark!.country} ${placeMark!.administrativeArea}'),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_right,
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomElevatedButton(
                      onPressed: placeMark == null
                          ? null
                          : () async {
                              final saleProductProvider = context.read<SaleProductNotifier>();
                              saleProductProvider.updateProduct(
                                productSellState: 'Sell',
                                locateCountry: 'Turkey',
                                locateCity: 'Izmir',
                              );

                              ProductCloudFireStoreService.instance.createProduct(
                                product: saleProductProvider.localProduct!,
                                images: saleProductProvider.images,
                              );

                              saleProductProvider.clearSaleProduct();

                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                      child: Text(
                        context.loc.releaseProduct,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
