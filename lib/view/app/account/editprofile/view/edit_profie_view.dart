import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/buildcontext/context_extension.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/loading/loading_screen.dart';
import 'package:second_hand/product/utilities/crop_image/crop_image.dart';
import 'package:second_hand/product/utilities/dialogs/ignore_changes_dialog.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/app/account/editprofile/view/select_image_bottom_sheet.dart';
import 'package:second_hand/view/app/account/editprofile/viewmodel/edit_profile_notifier.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final TextEditingController nameController;
  late final TextEditingController aboutYouController;
  late final TextEditingController emailController;
  @override
  void initState() {
    final user = context.read<UserInformationNotifier>().userInformation!;
    nameController = TextEditingController(text: user.name);
    aboutYouController = TextEditingController(text: user.aboutYou);
    emailController = TextEditingController(text: AuthService.firebase().currentUser!.email);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutYouController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> leaveEditView() async {
    final isAnyChanges = context.read<EditProfileNotifier>().anyChanges(
          newName: nameController.text,
          newAboutYou: aboutYouController.text,
        );
    if (isAnyChanges) {
      final isWillIgnore = await ignoreChanges(context);
      if (!isWillIgnore) return;
    }

    context.read<EditProfileNotifier>().clearEditProfileInformations();
    Navigator.of(context).pop();
  }

  // bir provider'ın başka bir providerla haberleşmesi normal anlaşılır
  Future<void> saveChangesAndLeaveEditView() async {
    LoadingScreen().show(context: context, text: 'wait');

    final profilePhotoDownloadUrl = await context.read<EditProfileNotifier>().changeFirebasePhotoIfPhotoChange(
          userId: AuthService.firebase().currentUser!.id,
        );
    if (profilePhotoDownloadUrl == null) {
      LoadingScreen().hide();
    } else {
      context.read<UserInformationNotifier>().updateUserInformation(
            name: nameController.text,
            aboutYou: aboutYouController.text,
            profilePhotoPath: profilePhotoDownloadUrl,
          );

      LoadingScreen().hide();

      await UserCloudFireStoreService.instance.updateUserInformation(
        userId: AuthService.firebase().currentUser!.id,
        name: nameController.text,
        profilePhotoDownloadUrl: profilePhotoDownloadUrl,
        aboutYou: aboutYouController.text,
      );
    }

    Navigator.pop(context);
  }

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
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: context.colors.secondary,
                  ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              padding: context.paddingOnlyTopSmall + context.paddingOnlyBottomSmall,
              child: IgnorePointer(
                child: CustomTextFormField(controller: emailController, labelText: 'E-mail adress'),
              ),
            ),
            const Text(
              'You are a verified user. Buyers will take this into account. ',
              textAlign: TextAlign.center,
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

// Change Photo
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
        // ask, from gallery ? or camera
        final photo = await SelectPhotoFromBottomSheet().show<File>(context);
        if (photo == null) return;
        // want to crop image or not ?
        final croppedFile = await CropImage.instance.croppedFile(context: context, imageFilePath: photo.path);
        if (croppedFile == null) return;

        final croppedPhoto = File(croppedFile.path);

        appearPhoto = croppedPhoto;

        context.read<EditProfileNotifier>().setEditProfileInformations(image: appearPhoto);

        setState(() {});
      },
      child: CircleAvatar(
        radius: 60,
        backgroundImage: appearPhoto != null
            ? FileImage(appearPhoto!) as ImageProvider
            : NetworkImage(
                context.read<UserInformationNotifier>().userInformation!.profilePhotoPath,
              ),
        child: Icon(
          Icons.camera_alt_outlined,
          color: context.colors.secondary,
          size: context.dynamicWidth(0.24),
        ),
      ),
    );
  }
}
