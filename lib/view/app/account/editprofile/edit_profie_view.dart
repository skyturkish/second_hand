import 'dart:developer' as devtools show log;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/loading/loading_screen.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';
import 'package:second_hand/utilities/dialogs/ignore_changes_dialog.dart';
import 'package:second_hand/view/_product/_widgets/circleavatar/profile_photo.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';

extension Log on Object? {
  void log() => devtools.log(toString());
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  Uint8List? oldPhoto;
  Uint8List? displayPhoto;
  File? fileForStroage;
  late final TextEditingController nameController;
  late final TextEditingController aboutYouController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    oldPhoto = context.read<UserInformationNotifier>().userPhoto;
    displayPhoto = context.read<UserInformationNotifier>().userPhoto;
    final user = context.read<UserInformationNotifier>().userInformation;
    nameController = TextEditingController(text: user.name);
    aboutYouController = TextEditingController(text: user.aboutYou);
    phoneController = TextEditingController(text: user.phoneNumber);
    emailController = TextEditingController(text: AuthService.firebase().currentUser!.email);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutYouController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            // TODO öncesinde değişiklik var mı diye kontrol et
            final isWillIgnore = await ignoreChanges(context);
            if (!isWillIgnore) return;
            context.read<UserInformationNotifier>().changeProfilePhoto(uint8List: oldPhoto);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              LoadingScreen().show(context: context, text: 'wait');

              await UserCloudFireStoreService.instance.updateUserInformation(
                userId: AuthService.firebase().currentUser!.id,
                name: nameController.text,
                aboutYou: aboutYouController.text,
              ); // TODO ikisinden birini ortak alalım ya da almayalım
              if (!mounted) return;
              await context.read<UserInformationNotifier>().changeUserInformation(
                    // ismini local yap
                    name: nameController.text,
                    aboutYou: aboutYouController.text,
                  );
              if (!mounted) return;
              await context.read<UserInformationNotifier>().changeProfilePhotoFirebase(file: fileForStroage);
              await context.read<UserInformationNotifier>().changeProfilePhotoPathFirebase();
              LoadingScreen().hide();
              if (!mounted) return;
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Simple Informations',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      // TODO ya show'dan nereye gideceğimiz seçeriz ya da direkt resmi alırız

                      final photo = await SelecPhotoBottomSheet().show<File>(context);
                      fileForStroage = photo;
                      photo.log();
                      if (photo == null) return;
                      displayPhoto = photo.readAsBytesSync();
                      context.read<UserInformationNotifier>().changeProfilePhoto(uint8List: displayPhoto);
                    },
                    child: const ProfilePhotoCircleFromLocal(),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: CustomTextFormField(
                      controller: nameController,
                      labelText: 'Enter name',
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: CustomTextFormField(
                controller: aboutYouController,
                labelText: 'Write about you',
              ),
            ),
            Padding(
              padding: context.paddingOnlyTopMedium,
              child: Text(
                'Communication İnformation',
                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Placeholder(),
              ),
            ),
            CustomTextFormField(controller: emailController, labelText: 'E-mail adress'),
            const Text('E posta adresini doğruladın, artık güvenli bir satıcı ve alıcısın bla bla bla '),
            const Divider(),
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: Text(
                'Ek Bilgiler',
                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension SelectImageFrom on SelecPhotoBottomSheet {
  // --> from https://vbacik-10.medium.com/season-two-flutter-short-but-golds-8cff8f4b0b29
  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(context: context, builder: (context) => this);
  }
}

// extension CustomPageSheet on EditProfileView {
//   Future<T?> show<T>(BuildContext context) {
//     return showModalBottomSheet(context: context, builder: (context) => this);
//   }
// }

class SelecPhotoBottomSheet extends StatelessWidget {
  SelecPhotoBottomSheet({Key? key}) : super(key: key);
  File? photo;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: const Text('From camera'),
          onTap: () async {
            final XFile? selectedImage = await _picker.pickImage(source: ImageSource.camera);
            photo = File(selectedImage!.path);
            Navigator.pop<File?>(context, photo);
          },
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('From gallery'),
          onTap: () async {
            final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
            photo = File(selectedImage!.path);
            Navigator.pop<File?>(context, photo);
          },
        ),
        const ListTile(),
      ],
    );
  }
}
