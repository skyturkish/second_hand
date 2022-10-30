import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/product/utilities/crop_image/crop_image.dart';
import 'package:second_hand/view/_product/_widgets/textformfield/custom_text_form_field.dart';
import 'package:second_hand/view/app/account/editprofile/view/select_image_bottom_sheet.dart';
import 'package:second_hand/view/app/account/editprofile/viewmodel/edit_profile_notifier.dart';
import 'package:second_hand/view/app/account/editprofile/viewmodel/edit_profile_view_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
  });
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
            child: Text(
              context.loc.save,
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
              context.loc.informations,
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
                child: CustomTextFormField(controller: emailController, labelText: context.loc.email),
              ),
            ),
            Text(
              context.loc.youAreAVerifiedUser,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EnterNameTextFormField extends StatefulWidget {
  const EnterNameTextFormField({
    super.key,
    required this.nameController,
  });

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
        labelText: context.loc.enterName,
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
    super.key,
    required this.aboutYouController,
  });

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
        labelText: context.loc.writeAboutYou,
        maxLetter: 150,
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }
}

class EditProfilePhotoView extends StatefulWidget {
  const EditProfilePhotoView({
    super.key,
  });

  @override
  State<EditProfilePhotoView> createState() => _EditProfilePhotoViewState();
}

class _EditProfilePhotoViewState extends State<EditProfilePhotoView> {
  File? appearPhoto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final photo = await const SelectPhotoFromBottomSheet().show<File>(context);

        if (photo == null) return;

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
