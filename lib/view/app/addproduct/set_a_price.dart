import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/product/product-service.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:uuid/uuid.dart';

class SetAPriceView extends StatefulWidget {
  const SetAPriceView({Key? key}) : super(key: key);

  @override
  State<SetAPriceView> createState() => SetAPriceViewState();
}

class SetAPriceViewState extends State<SetAPriceView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _priceController;

  @override
  void initState() {
    _priceController = TextEditingController(text: context.read<ProductNotifier>().currentProduct.price.toString());
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetAPrice'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: context.paddingAllMedium,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _priceController,
                labelText: 'price',
                keyboardType: TextInputType.number,
                prefix: const Icon(
                  Icons.money,
                ),
                onChanged: (String text) {
                  text.log();
                  setState(() {});
                },
              ),
              ElevatedButton(
                onPressed: int.parse(_priceController.text) > 0
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final String productId = const Uuid().v4();

                          context.read<ProductNotifier>().setProduct(
                                price: int.parse(_priceController.text),
                                ownerId: AuthService.firebase().currentUser!.id,
                                productId: productId,
                              );

                          Future.delayed(
                            const Duration(milliseconds: 10),
                          );

                          context.read<ProductNotifier>().skytoString();

                          ProductCloudFireStoreService.instance.createProduct(
                            product: context.read<ProductNotifier>().product,
                            images: context.read<ProductNotifier>().images,
                          );

                          context.read<ProductNotifier>().clearProduct();

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      },
                child: const Text(
                  'Release Product',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
