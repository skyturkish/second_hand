import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';
import 'package:second_hand/utilities/dialogs/ignore_changes_dialog.dart';
import 'package:second_hand/view/_product/_widgets/circleavatar/profile_photo.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key, required this.photo}) : super(key: key);
  final Uint8List? photo;
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  Uint8List? showPhoto;
  late final TextEditingController nameController;
  late final TextEditingController aboutYouController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    showPhoto = widget.photo;
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
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await UserCloudFireStoreService.instance.updateUserInformation(
                userId: AuthService.firebase().currentUser!.id,
                name: nameController.text,
                aboutYou: aboutYouController.text,
              ); // TODO ikisinden birini ortak alalım ya da almayalım
              await context.read<UserInformationNotifier>().changeUserInformation(
                    name: nameController.text,
                    aboutYou: aboutYouController.text,
                  );
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
                    onTap: () {
                      final bursa = const Adana().show<String>(context);

                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                      print(bursa);
                    },
                    child: ProfilePhotoCircle(
                      photo: showPhoto,
                    ),
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

extension SelectImageFrom on Adana {
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

class Adana extends StatelessWidget {
  const Adana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop<String>(context, 'allahım olsun amin');
      },
      child: const Text('data'),
    );
  }
}
