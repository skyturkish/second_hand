import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/loading/loading_screen.dart';
import 'package:second_hand/product/utilities/dialogs/ignore_changes_dialog.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';
import 'package:second_hand/view/app/account/editprofile/view/edit_profie_view.dart';
import 'package:second_hand/view/app/account/editprofile/viewmodel/edit_profile_notifier.dart';

abstract class EditProfileViewModel extends State<EditProfileView> {
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

  Future<void> saveChangesAndLeaveEditView() async {
    LoadingScreen().show(context: context, text: context.loc.wait);

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
}
