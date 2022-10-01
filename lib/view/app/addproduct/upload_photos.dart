import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/core/init/notifier/product_notifer.dart';

class UploadPhotosView extends StatefulWidget {
  const UploadPhotosView({Key? key}) : super(key: key);

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
            height: context.dynamicHeight(0.40),
            width: context.dynamicWidth(0.90),
            child: PageView.builder(
              itemCount: context.watch<ProductNotifier>().images.length,
              itemBuilder: (context, index) {
                return context.watch<ProductNotifier>().images.isEmpty
                    ? Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.black,
                        ),
                      )
                    : Image.file(
                        context.watch<ProductNotifier>().images[index],
                        fit: BoxFit.cover,
                      );
              },
            ),
          ),
          const Divider(
            height: 5,
            thickness: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final List<XFile>? images = await _picker.pickMultiImage(
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
                  final XFile? xFileimage = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                  );

                  final File fileImage = File(xFileimage!.path);

                  context.read<ProductNotifier>().addImages(
                    newImages: [fileImage],
                  );
                },
                child: const Text('Take a picture'),
              ),
            ],
          ),
          const Spacer(),
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
