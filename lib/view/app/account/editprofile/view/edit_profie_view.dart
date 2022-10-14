import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/utilities/crop_image/crop_image.dart';
import 'package:second_hand/view/_product/_widgets/divider/general_divider.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/app/account/editprofile/view/select_image_bottom_sheet.dart';
import 'package:second_hand/view/app/account/editprofile/viewmodel/edit_profie_view_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends EditProfileViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await leaveEditView();
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await saveChangesAndLeaveEditView();
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
            const NormalDivider(),
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

// Enter name Text Form Field
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

// Write About you Text Form Field
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

// Change Photo // TODO buna tıklamayı belli edecek bir şey ekle
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
        final croppedFile = await CropImage.instance.croppedFile(context: context, imageFilePath: photo.path);
        if (croppedFile == null) return;
        final croppedPhoto = File(croppedFile.path);

        appearPhoto = croppedPhoto;
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
