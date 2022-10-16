import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/loading/loading_screen.dart';
import 'package:second_hand/services/auth/auth_service.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';
import 'package:second_hand/product/utilities/dialogs/ignore_changes_dialog.dart';
import 'package:second_hand/view/app/account/editprofile/view/edit_profie_view.dart';

abstract class EditProfileViewModel extends State<EditProfileView> {
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

  Future<void> leaveEditView() async {
    final isAnyChanges = context.read<UserInformationNotifier>().anyChanges(
          name: nameController.text,
          aboutYou: aboutYouController.text,
        );

    if (isAnyChanges) {
      final isWillIgnore = await ignoreChanges(context);
      if (!isWillIgnore) return;
    }

    context.read<UserInformationNotifier>().clearLocalPhoto();
    Navigator.of(context).pop();
  }

  Future<void> saveChangesAndLeaveEditView() async {
    LoadingScreen().show(context: context, text: 'wait');

    await context.read<UserInformationNotifier>().changeUserInformationLocal(
          name: nameController.text,
          aboutYou: aboutYouController.text,
        );
    // hem firebase bekliyoruz hem şunu bu düzeltirlebilir
    await context.read<UserInformationNotifier>().saveProfilePhotoToFirebaseIfPhotoChange(context: context);

    LoadingScreen().hide();

    await UserCloudFireStoreService.instance.updateUserInformation(
      userId: AuthService.firebase().currentUser!.id,
      name: nameController.text,
      aboutYou: aboutYouController.text,
    ); // TODO ikisinden birini ortak alalım ya da almayalım

    Navigator.pop(context);
  }
}
