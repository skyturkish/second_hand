import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/view/enum_product_state.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/view/include_some_details_view.dart';

abstract class IncludeSomeDetailsViewModel extends State<IncludeSomeDetailsView> {
  final formKey = GlobalKey<FormState>();

  ProductState valueProductState = ProductState.values.last;

  late final TextEditingController stateController;
  late final TextEditingController titleController;
  late final TextEditingController describeController;

  @override
  void initState() {
    final productInformation = context.read<SaleProductNotifier>().localProduct;
    stateController = TextEditingController(text: productInformation?.condition ?? '');
    titleController = TextEditingController(text: productInformation?.title ?? '');
    describeController = TextEditingController(text: productInformation?.description ?? '');
    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();
    titleController.dispose();
    describeController.dispose();
    super.dispose();
  }
}
