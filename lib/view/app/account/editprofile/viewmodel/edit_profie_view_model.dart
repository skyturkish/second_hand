import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/init/notifier/user_information_notifier.dart';
import 'package:second_hand/service/auth/auth_service.dart';
import 'package:second_hand/view/app/account/editprofile/view/edit_profie_view.dart';

abstract class EditProfileViewModel extends State<EditProfileView> {
  // TEXT CONTROLLER
  late final TextEditingController nameController;
  late final TextEditingController aboutYouController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  // PHOTOS
  Uint8List? oldPhoto;
  Uint8List? displayPhoto;
  File? fileForStroage;

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
}
