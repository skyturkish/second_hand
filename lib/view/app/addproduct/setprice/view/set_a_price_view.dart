import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/view/_product/_widgets/button/custom_elevated_button.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/app/addproduct/setprice/viewmodel/set_a_price_view_model.dart';

class SetAPriceView extends StatefulWidget {
  const SetAPriceView({super.key});

  @override
  State<SetAPriceView> createState() => SetAPriceViewState();
}

class SetAPriceViewState extends SetAPriceViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetAPrice'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: context.paddingAllMedium,
          child: Column(
            children: [
              PriceTextFormField(priceController: priceController),
              const Spacer(),
              ReleaseProductButton(formKey: formKey, priceController: priceController),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceTextFormField extends StatelessWidget {
  const PriceTextFormField({
    Key? key,
    required TextEditingController priceController,
  })  : _priceController = priceController,
        super(key: key);

  final TextEditingController _priceController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _priceController,
      labelText: 'price',
      keyboardType: TextInputType.number,
      prefix: const Icon(
        Icons.money,
      ),
      inputFormatters: [
        // only let positivi numbers -->
        // from https://stackoverflow.com/questions/71841263/flutter-textfield-only-positive-numbers
        FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*')),
      ],
    );
  }
}

class ReleaseProductButton extends StatelessWidget {
  const ReleaseProductButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController priceController,
  })  : _formKey = formKey,
        _priceController = priceController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _priceController;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<SaleProductNotifier>().updateProduct(
                price: int.parse(_priceController.text),
                ownerId: AuthService.firebase().currentUser!.id,
              );

          context.read<SaleProductNotifier>().releaseProduct();

          // burası hiç güzel olmadı ama
          // 3 geri çıkıp tekrar blocğun içine giriyoruz çünk,
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      child: const Text(
        'Release Product',
      ),
    );
  }
}
