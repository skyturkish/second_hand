import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/viewmodel/include_some_details_view_model.dart';
part 'include_some_details_view_part.dart';

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
  const IncludeSomeDetailsView({super.key});

  @override
  State<IncludeSomeDetailsView> createState() => IncludeSomeDetailsViewState();
}

class IncludeSomeDetailsViewState extends IncludeSomeDetailsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Include some details'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: context.paddingAllMedium,
          child: Column(
            children: [
              TitleTextFormField(titleController: titleController),
              DescriptionTextFormField(describeController: describeController),
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
                      stateController.text = productState!.name;
                      valueProductState = productState;
                    },
                  );
                },
              ),
              const Spacer(),
              NextButton(
                  formKey: formKey,
                  titleController: titleController,
                  stateController: stateController,
                  describeController: describeController),
            ],
          ),
        ),
      ),
    );
  }
}
