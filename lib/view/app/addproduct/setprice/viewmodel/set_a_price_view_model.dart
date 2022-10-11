import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/view/app/addproduct/setprice/view/set_a_price_view.dart';

abstract class SetAPriceViewModel extends State<SetAPriceView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController priceController;

  @override
  void initState() {
    priceController = TextEditingController(text: context.read<ProductNotifier>().localProduct.price.toString());
    super.initState();
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }
}
