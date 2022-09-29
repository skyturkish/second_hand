import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extension/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';

enum ProductState {
  verybad(name: 'Very Bad'),
  bad(name: 'Bad'),
  normal(name: 'Normal'),
  good(name: 'Good'),
  verygood(name: 'Very Good');

  const ProductState({required this.name});

  final String name;
}

class IncludeSomeDetailsView extends StatefulWidget {
  const IncludeSomeDetailsView({Key? key}) : super(key: key);

  @override
  State<IncludeSomeDetailsView> createState() => IncludeSomeDetailsViewState();
}

class IncludeSomeDetailsViewState extends State<IncludeSomeDetailsView> {
  // TODO texteditincontroller'e ayrı ayrı validator yazmalısın
  // TODO minimmum text miktarı olacak unutma
  final _formKey = GlobalKey<FormState>();

  ProductState valueProductState = ProductState.values.last;

  late final TextEditingController _stateController;
  late final TextEditingController _titleController;
  late final TextEditingController _describeController;

  @override
  void initState() {
    _stateController = TextEditingController(text: context.read<ProductNotifier>().product.state);
    _titleController = TextEditingController(text: context.read<ProductNotifier>().product.title);
    _describeController = TextEditingController(text: context.read<ProductNotifier>().product.description);
    super.initState();
  }

  @override
  void dispose() {
    _stateController.dispose();
    _titleController.dispose();
    _describeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Include some details'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: context.paddingAllMedium,
          child: Column(
            children: [
              Padding(
                padding: context.paddingOnlyTopSmall,
                child: CustomTextFormField(
                  controller: _titleController,
                  labelText: 'title',
                  prefix: const Icon(Icons.title_outlined),
                ),
              ),
              Padding(
                padding: context.paddingOnlyTopSmall,
                child: CustomTextFormField(
                  controller: _describeController,
                  labelText: 'description',
                  prefix: const Icon(Icons.description),
                ),
              ),
              DropdownButton<ProductState>(
                value: valueProductState,
                items: ProductState.values
                    .map<DropdownMenuItem<ProductState>>(
                      (value) => DropdownMenuItem<ProductState>(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
                onChanged: (productState) {
                  setState(
                    () {
                      _stateController.text = productState!.name;
                      valueProductState = productState;
                    },
                  );
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ProductNotifier>().setProduct(
                          title: _titleController.text,
                          state: _stateController.text,
                          description: _describeController.text,
                        );
                    NavigationService.instance.navigateToPage(path: NavigationConstants.UPLOAD_PHOTOS);
                  }
                },
                child: const Text(
                  'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
