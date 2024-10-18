import 'package:flutter/material.dart';
import 'package:fyp_v101/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MenuBarSettings extends StatefulWidget {
  const MenuBarSettings({super.key});

  @override
  State<MenuBarSettings> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBarSettings> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = MediaQuery.of(context).size.width;
          // double iconWidth =
          //     screenWidth / 3; // Assuming 3 icons in the bottom navigation bar
          // double iconHeight = 32; // Adjust the height of the icons as needed

          return Stack(
            children: [
              Container(
                height: 60,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // Center icons vertically
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the stats_page when the image is tapped
                        Get.toNamed(Routes.HOME);
                      },
                      child: Image.asset(
                        'imgs/home_icon.png',
                        width: 32,
                        height: 32,
                      ),
                    ),

                    // Replace with your custom home icon
                    GestureDetector(
                      onTap: () {
                        // Navigate to the stats_page when the image is tapped
                        Get.toNamed(Routes.STATS);
                      },
                      child: Image.asset(
                        'imgs/stats_icon.png',
                        width: 32,
                        height: 32,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        // Navigate to the stats_page when the image is tapped
                        Get.toNamed(Routes.SETTING);
                      },
                      child: Image.asset(
                        'imgs/setting_icon1.png',
                        width: 32,
                        height: 32,
                      ),
                    ), // Replace with your custom stats icon
                  ],
                ),
              ),
              Positioned(
                bottom: (5) / 2, // Center the circle vertically
                left: 0.82 * screenWidth, // Adjust the position of the circle
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 15, 80, 220),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
