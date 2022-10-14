import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/view/enum_product_state.dart';
import 'package:second_hand/view/app/addproduct/include_some_details/viewmodel/include_some_details_view_model.dart';

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
                // TODO tüm sayfa yenileniyor burada, bunu engelleyebilirdik valuelisten ile
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

class TitleTextFormField extends StatefulWidget {
  const TitleTextFormField({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  State<TitleTextFormField> createState() => _TitleTextFormFieldState();
}

class _TitleTextFormFieldState extends State<TitleTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: CustomTextFormField(
        controller: widget.titleController,
        labelText: 'title',
        prefix: const Icon(Icons.title_outlined),
        maxLetter: 50,
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }
}

class DescriptionTextFormField extends StatefulWidget {
  const DescriptionTextFormField({
    Key? key,
    required this.describeController,
  }) : super(key: key);

  final TextEditingController describeController;

  @override
  State<DescriptionTextFormField> createState() => _DescriptionTextFormFieldState();
}

class _DescriptionTextFormFieldState extends State<DescriptionTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: CustomTextFormField(
        line: 4,
        controller: widget.describeController,
        labelText: 'description',
        prefix: const Icon(Icons.description),
        maxLetter: 150,
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    required this.formKey,
    required this.titleController,
    required this.stateController,
    required this.describeController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController stateController;
  final TextEditingController describeController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<ProductNotifier>().updateProduct(
                title: titleController.text,
                state: stateController.text,
                description: describeController.text,
              );
          NavigationService.instance.navigateToPage(path: NavigationConstants.UPLOAD_PHOTOS);
        }
      },
      child: const Text(
        'Next',
      ),
    );
  }
}
