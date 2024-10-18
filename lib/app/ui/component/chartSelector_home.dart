import 'package:flutter/material.dart';
import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/ui/component/lineCharthome1.dart';
import 'package:fyp_v101/app/ui/component/monthly_barGraph.dart';
import 'package:fyp_v101/app/ui/component/weekly_barGraph.dart';
import 'package:get/get.dart';

class SelectedLineChartWidget extends GetView<HomeController> {
  const SelectedLineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.selectedButton.value) {
        case 'Hours':
          return const linechartHomePage1();
        case 'Day':
          return const WeeklyBarGraph();
        case 'Week':
          return const MonthlyBarGraph();
        case 'Year':
          return const MonthlyBarGraph();
        default:
          return Container();
      }
    });
  }
}
