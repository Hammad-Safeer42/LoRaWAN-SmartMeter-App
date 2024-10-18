import 'package:flutter/material.dart';
import 'package:fyp_v101/app/modules/auth/views/login.view.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}
