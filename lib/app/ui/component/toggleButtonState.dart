import 'package:flutter/material.dart';
import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/routes/app_pages.dart';
import 'package:fyp_v101/app/ui/component/chart_bottons.dart';
import 'package:get/get.dart';

class ToggleButtonState extends StatefulWidget {
  const ToggleButtonState({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToggleButtonStateState createState() => _ToggleButtonStateState();
}

class _ToggleButtonStateState extends State<ToggleButtonState> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(), // Initialize the controller
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              ToggleButton(
                buttonText: 'Hours',
                selected: controller.selectedButton.value == 'Hours',
                onPressed: () {
                  setState(() {
                    controller.setButton('Hours');
                    // Update selected button
                  });
                },
              ),
              const SizedBox(width: 8),
              const Spacer(),
              ToggleButton(
                buttonText: 'Day',
                selected: controller.selectedButton.value == 'Day',
                onPressed: () {
                  setState(() {
                    controller.setButton('Day');
                    // Update selected button
                  });
                },
              ),
              const SizedBox(width: 8),
              const Spacer(),
              ToggleButton(
                buttonText: 'Week',
                selected: controller.selectedButton.value == 'Week',
                onPressed: () {
                  setState(() {
                    controller.setButton('Week');
                    // Update selected button
                  });
                },
              ),
              const SizedBox(width: 8),
              const Spacer(),
              ToggleButton(
                buttonText: 'Year',
                selected: controller.selectedButton.value == 'Year',
                onPressed: () {
                  setState(() {
                    controller.setButton('Year');
                    Get.toNamed(Routes.STATS);
                    // Update selected button
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
