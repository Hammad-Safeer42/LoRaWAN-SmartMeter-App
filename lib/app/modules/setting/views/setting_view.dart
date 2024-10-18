import 'package:flutter/material.dart';
import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/modules/setting/views/setting_page.dart';

import 'package:get/get.dart';

class SettingView extends GetView<HomeController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SettingsPage();
  }
}
