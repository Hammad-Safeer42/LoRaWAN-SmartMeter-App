import 'package:flutter/material.dart';
import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/modules/stats/views/stats_page.dart';

import 'package:get/get.dart';

class StatsView extends GetView<HomeController> {
  const StatsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatsPage();
  }
}
