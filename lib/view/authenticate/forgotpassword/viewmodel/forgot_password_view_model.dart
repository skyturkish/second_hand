import 'package:flutter/material.dart';
import 'package:second_hand/view/authenticate/forgotpassword/view/forgot_password_view.dart';

abstract class ForgotPasswordViewModel extends State<ForgotPasswordView> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
