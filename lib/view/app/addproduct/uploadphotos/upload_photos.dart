import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/enums/lottie_animation_enum.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/product/utilities/image_pick/image_picker_manager.dart';
import 'package:second_hand/view/app/addproduct/sale_product_notifier.dart';
import 'package:second_hand/view/_product/_widgets/animation/lottie_animation_view.dart';
import 'package:second_hand/view/_product/_widgets/button/custom_elevated_button.dart';

class UploadPhotosView extends StatelessWidget {
  const UploadPhotosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Upload Photos'),
      ),
      body: Column(
        children: [
          const PageViewImages(),
          Divider(thickness: 6, height: context.dynamicHeight(0.03)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              FromGalleryButton(),
              TakeAPictureButton(),
            ],
          ),
          Divider(thickness: 6, height: context.dynamicHeight(0.03)),
          const ImagesGridView(),
          const Spacer(),
          Padding(
            padding: context.paddingOnlyBottomMedium,
            child: const NextButton(),
          ),
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
    final saleProductProvider = context.watch<SaleProductNotifier>();
    return SizedBox(
      height: context.dynamicHeight(0.34),
      width: context.dynamicWidth(0.90),
      child: saleProductProvider.images.isEmpty
          ? const LottieAnimationView(animation: LottieAnimation.uploadPhotos)
          : PageView.builder(
              itemCount: saleProductProvider.images.length,
              itemBuilder: (context, index) {
                return Image.file(
                  context.read<SaleProductNotifier>().images[index],
                  fit: BoxFit.contain,
                );
              },
            ),
    );
  }
}

class FromGalleryButton extends StatelessWidget {
  const FromGalleryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      dynamicWidth: 0.4,
      borderRadius: 10,
      onPressed: () async {
        final xFileImages = await ImagePickerManager.instance.pickMultiImage();

        final fileImages = xFileImages!.map(
          (xFile) => File(
            xFile.path,
          ),
        );
        context.read<SaleProductNotifier>().addImages(
              newImages: fileImages.toList(),
            );
      },
      child: const Text('From gallery'),
    );
  }
}

class TakeAPictureButton extends StatelessWidget {
  const TakeAPictureButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      dynamicWidth: 0.4,
      borderRadius: 10,
      onPressed: () async {
        final xFileImage = await ImagePickerManager.instance.pickSingleImage(
          imageSource: ImageSource.camera,
        );

        final fileImage = File(xFileImage!.path);

        context.read<SaleProductNotifier>().addImages(
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
  // tüm kareyi kaplaması için şunu sağdan ve soldan çekiştirsene , Positional.fill'in içine - değer vererek
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.34),
      width: context.dynamicWidth(0.90),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: context.watch<SaleProductNotifier>().images.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Center(
                child: Image.file(
                  context.read<SaleProductNotifier>().images[index],
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<SaleProductNotifier>().removeImage(index: index);
                },
                icon: const Icon(Icons.remove_circle),
                color: context.colors.error,
              ),
            ],
          );
        },
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
    return CustomElevatedButton(
      onPressed: () {
        if (context.read<SaleProductNotifier>().images.isEmpty) {
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
