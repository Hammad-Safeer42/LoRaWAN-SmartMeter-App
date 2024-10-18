import 'package:flutter/material.dart';
import 'package:fyp_v101/app/modules/home/views/home_page.view.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
