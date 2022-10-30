import 'package:flutter/material.dart';
import 'package:second_hand/view/authenticate/register/view/register_view.dart';

abstract class RegisterViewModel extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
