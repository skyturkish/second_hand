import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/extensions/string_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';

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
          SizedBox(
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
          ),
          const Divider(
            height: 5,
            thickness: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
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
              ),
              ElevatedButton(
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
              ),
            ],
          ),
          SingleChildScrollView(
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
          ),
          ElevatedButton(
            // TODO 0 fotoğraf olunca işlevini de kaybettirebilirsin.
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
          ),
        ],
      ),
    );
  }
}
