import 'package:flutter/material.dart';
import 'package:second_hand/view/authenticate/login/view/login_view.dart';

abstract class LoginViewmodel extends State<LoginView> {
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
