import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';
import 'package:second_hand/view/app/home/home_product_card.dart';
import 'package:second_hand/view/app/home/storage_image_view.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.product, required this.storageRef});
  final Product product;
  final Reference storageRef;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PageView.builder(
                allowImplicitScrolling: true,
                itemCount: product.imagesPath.length,
                itemBuilder: (context, index) {
                  final mountainImagesRef = storageRef.child(product.imagesPath[index]);
                  return StorageImageView(
                    image: mountainImagesRef,
                  );
                },
              ),
            ),
            Padding(
              padding: context.paddingHorizontalSmall + context.paddingOnlyTopSmall,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price} TL',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Padding(
                        padding: context.paddingOnlyTopSmall,
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                  FavoriteIconButton(
                    product: product,
                    provider: context.read<UserInformationNotifier>(),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: context.paddingHorizontalSmall,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: context.paddingOnlyTopSmall,
                    child: Text(
                      'Description',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: context.paddingOnlyTopSmall,
                    child: Text(
                      product.description,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            FutureBuilder(
              future: UserCloudFireStoreService.instance.getUserInformationById(userId: product.ownerId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data as UserInformation;

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 45,
                      child: ProfilePhotoCircle(
                        image: storageRef.child(user.profilePhotoPath),
                      ),
                    ),
                    title: Text(user.name),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right_outlined,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class ProfilePhotoCircle extends StatefulWidget {
  const ProfilePhotoCircle({
    super.key,
    required this.image,
  });

  final Reference image;

  @override
  State<ProfilePhotoCircle> createState() => _ProfilePhotoCircleState();
}

class _ProfilePhotoCircleState extends State<ProfilePhotoCircle> {
  Uint8List? photo;

  @override
  void initState() {
    getImage();
    super.initState();
  }

  Future<void> getImage() async {
    photo = await widget.image.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45,
      backgroundImage:
          // TODO buraya gerçekten geç geldiği zaman karşıdakinin geç geleceğini anladığın bir fotoğraf koyarsın
          photo == null ? const AssetImage('assets/images/dog_eats_bread.jpg') : MemoryImage(photo!) as ImageProvider,
    );
  }
}
