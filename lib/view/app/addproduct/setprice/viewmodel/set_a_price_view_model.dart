import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';
import 'package:second_hand/view/app/addproduct/setprice/view/set_a_price_view.dart';

abstract class SetAPriceViewModel extends State<SetAPriceView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController priceController;

  @override
  void initState() {
    priceController = TextEditingController(
      text: context.read<SaleProductNotifier>().localProduct?.price.toString() ?? '1',
    );
    super.initState();
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }
}
