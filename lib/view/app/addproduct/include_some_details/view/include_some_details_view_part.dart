part of 'include_some_details_view.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: CustomTextFormField(
        controller: titleController,
        labelText: 'title',
        prefix: const Icon(Icons.title_outlined),
      ),
    );
  }
}

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField({
    Key? key,
    required this.describeController,
  }) : super(key: key);

  final TextEditingController describeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: CustomTextFormField(
        controller: describeController,
        labelText: 'description',
        prefix: const Icon(Icons.description),
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
          context.read<ProductNotifier>().setProduct(
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
