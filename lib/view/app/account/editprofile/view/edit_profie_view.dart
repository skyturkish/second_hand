import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/loading/loading_screen.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';
import 'package:second_hand/utilities/dialogs/ignore_changes_dialog.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/app/account/editprofile/view/select_image_bottom_sheet.dart';
import 'package:second_hand/view/app/account/editprofile/viewmodel/edit_profie_view_model.dart';

// TODO githubda sana yardım eden adamın dediği gibi gelki fonksiyonlara ayırsan iyi olur burayı
// changeLocal, changeFirebase gibi şeylere daha kolay yönetilir, fonksiyonları direkt çağırıyorsun çünkü
class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}
// TODO bu sayfa çok karışık ya

class _EditProfileViewState extends EditProfileViewModel {
  // TEXT CONTROLLER
  late final TextEditingController nameController;
  late final TextEditingController aboutYouController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  @override
  void initState() {
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
            context.read<UserInformationNotifier>().resetChanges();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              LoadingScreen().show(context: context, text: 'wait');

              await context.read<UserInformationNotifier>().changeUserInformationLocal(
                    // ismini local yap
                    name: nameController.text,
                    aboutYou: aboutYouController.text,
                  );

              await context.read<UserInformationNotifier>().saveProfilePhotoToFirebaseIfPhotoChange(context: context);

              LoadingScreen().hide();

              await UserCloudFireStoreService.instance.updateUserInformation(
                userId: AuthService.firebase().currentUser!.id,
                name: nameController.text,
                aboutYou: aboutYouController.text,
              ); // TODO ikisinden birini ortak alalım ya da almayalım

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
                  const EditProfilePhotoView(),
                  EnterNameTextFormField(
                    nameController: nameController,
                  )
                ],
              ),
            ),
            WriteAboutYouTextFormField(aboutYouController: aboutYouController),
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

class EnterNameTextFormField extends StatefulWidget {
  const EnterNameTextFormField({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  State<EnterNameTextFormField> createState() => _EnterNameTextFormFieldState();
}

class _EnterNameTextFormFieldState extends State<EnterNameTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: CustomTextFormField(
        controller: widget.nameController,
        labelText: 'Enter name',
        maxLetter: 25,
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }
}

class WriteAboutYouTextFormField extends StatefulWidget {
  const WriteAboutYouTextFormField({
    Key? key,
    required this.aboutYouController,
  }) : super(key: key);

  final TextEditingController aboutYouController;

  @override
  State<WriteAboutYouTextFormField> createState() => _WriteAboutYouTextFormFieldState();
}

class _WriteAboutYouTextFormFieldState extends State<WriteAboutYouTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopSmall,
      child: CustomTextFormField(
        controller: widget.aboutYouController,
        labelText: 'Write about you',
        maxLetter: 150,
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }
}

class EditProfilePhotoView extends StatefulWidget {
  const EditProfilePhotoView({Key? key}) : super(key: key);

  @override
  State<EditProfilePhotoView> createState() => _EditProfilePhotoViewState();
}

class _EditProfilePhotoViewState extends State<EditProfilePhotoView> {
  File? appearPhoto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final photo = await SelecPhotoBottomSheet().show<File>(context);
        if (photo == null) return;
        appearPhoto = photo;
        context.read<UserInformationNotifier>().changeProfilePhotoLocal(image: appearPhoto);
        setState(() {});
      },
      child: CircleAvatar(
        radius: 60,
        backgroundImage: appearPhoto != null
            ? FileImage(appearPhoto!) as ImageProvider
            : NetworkImage(
                context.read<UserInformationNotifier>().userInformation.profilePhotoPath,
              ),
      ),
    );
  }
}
