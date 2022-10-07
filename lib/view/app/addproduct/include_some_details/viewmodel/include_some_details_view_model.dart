import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/view/enum_product_state.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/view/include_some_details_view.dart';

abstract class IncludeSomeDetailsViewModel extends State<IncludeSomeDetailsView> {
  // TODO texteditincontroller'e ayrı ayrı validator yazmalısın
  // TODO minimmum text miktarı olacak unutma
  final formKey = GlobalKey<FormState>();

  ProductState valueProductState = ProductState.values.last;

  late final TextEditingController stateController;
  late final TextEditingController titleController;
  late final TextEditingController describeController;

  @override
  void initState() {
    final productInformation = context.read<ProductNotifier>().product;
    stateController = TextEditingController(text: productInformation.state);
    titleController = TextEditingController(text: productInformation.title);
    describeController = TextEditingController(text: productInformation.description);
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
