import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/string/if_debugging.dart';
import 'package:second_hand/view/authenticate/login/view/login_view.dart';

abstract class LoginViewmodel extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController(text: 'gokturk.acr2002@gmail.com'.ifDebugging);
    passwordController = TextEditingController(text: 'deniyorum123'.ifDebugging);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
