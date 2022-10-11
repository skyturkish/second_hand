import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';
import 'package:second_hand/view/_product/_widgets/divider/general_divider.dart';

class UploadPhotosView extends StatefulWidget {
  const UploadPhotosView({super.key});

  @override
  State<UploadPhotosView> createState() => UploadPhotosViewState();
}

class UploadPhotosViewState extends State<UploadPhotosView> {
  late final ImagePicker _picker;
  @override
  void initState() {
    _picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('UploadPhotos'),
      ),
      body: Column(
        children: [
          const PageViewImages(),
          const NormalDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FromGalleryButton(picker: _picker),
              TakeAPictureButton(picker: _picker),
            ],
          ),
          const ImagesGridView(),
          const NextButton(),
        ],
      ),
    );
  }
}

class PageViewImages extends StatelessWidget {
  const PageViewImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.33),
      width: context.dynamicWidth(0.90),
      child: context.watch<ProductNotifier>().images.isEmpty
          ? Image.asset(ImageConstants.instance.addPhoto)
          : PageView.builder(
              itemCount: context.watch<ProductNotifier>().images.length,
              itemBuilder: (context, index) {
                return Image.file(
                  context.read<ProductNotifier>().images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}

class FromGalleryButton extends StatelessWidget {
  const FromGalleryButton({
    Key? key,
    required ImagePicker picker,
  })  : _picker = picker,
        super(key: key);

  final ImagePicker _picker;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final images = await _picker.pickMultiImage(
          maxHeight: 1024,
          maxWidth: 1024,
          imageQuality: 50,
        );
        final fileimages = images!.map(
          (xFile) => File(
            xFile.path,
          ),
        );
        context.read<ProductNotifier>().addImages(
              newImages: fileimages.toList(),
            );
      },
      child: const Text('From gallery'),
    );
  }
}

class TakeAPictureButton extends StatelessWidget {
  const TakeAPictureButton({
    Key? key,
    required ImagePicker picker,
  })  : _picker = picker,
        super(key: key);

  final ImagePicker _picker;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final xFileimage = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
        );
        final fileImage = File(xFileimage!.path);
        context.read<ProductNotifier>().addImages(
          newImages: [fileImage],
        );
      },
      child: const Text('Take a picture'),
    );
  }
}

class ImagesGridView extends StatelessWidget {
  const ImagesGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: context.dynamicHeight(0.40),
        width: context.dynamicWidth(0.90),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: context.watch<ProductNotifier>().images.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                context.read<ProductNotifier>().removeImage(index: index);
              },
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Image.file(
                    context.read<ProductNotifier>().images[index],
                    height: 200,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (context.read<ProductNotifier>().images.isEmpty) {
          const snackBar = SnackBar(
            content: Text('You must select at least one photo'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
        NavigationService.instance.navigateToPage(path: NavigationConstants.SET_A_PRICE);
      },
      child: const Text(
        'Next',
      ),
    );
  }
}
