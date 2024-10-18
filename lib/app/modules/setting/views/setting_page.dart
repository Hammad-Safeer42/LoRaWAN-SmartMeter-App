import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_v101/app/data/commonkeys.dart';
import 'package:fyp_v101/app/modules/auth/controllers/auth_controller.dart';

import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/ui/component/menu_bar_settings.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends GetView<HomeController> {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(controller.auth.appdata.value!.aboutLink);
    final Uri url2 = Uri.parse(controller.auth.appdata.value!.duplicateBill);

    //

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: 1.sw,
            height: 0.4.sh,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("imgs/settings_bg_top.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 123,
                ),
                CircleAvatar(
                  radius: 86,
                  child: ClipOval(
                    child: Image.network(
                      controller.auth.userdata.value!.image.validate(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  ' ${controller.auth.userdata.value?.extra['fullname']}',
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    color: Color(0xFF333333),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Acc No: ${controller.auth.userdata.value?.accountId}',
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    color: Color(0xFF4285F4),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 1.sw,
              height: 0.46.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // Adjust the radius for circular edges
                color: const Color.fromARGB(
                    54, 159, 175, 202), // Set your desired background color
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 10,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: Color(0xFF363B64),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  /////////////////////////
                  ///

                  ///
                  ///    Daily Billing Update
                  ///

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 15,
                    ),
                    child: Container(
                        width: 1.sw,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              12), // Adjust the radius for circular edges
                          color: const Color(
                              0xffffffff), // Set your desired background color
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Daily Usage Notificaiton",
                                style: TextStyle(
                                  color: Color(0xffADAFBD),
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            // ...

// ...

                            Expanded(child: Container()),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Obx(() => AdvancedSwitch(
                                    activeColor: const Color(0xff4285F4),
                                    inactiveColor: Colors.grey,
                                    activeChild: const Text('ON'),
                                    inactiveChild: const Text('OFF'),
                                    initialValue:
                                        controller.isNotificationEnabled.value,

                                    onChanged: (value) {
                                      controller.isNotificationEnabled.value =
                                          value;
                                      setValue(dailyUsageNotification, value);
                                    },
                                    // activeImage: AssetImage('imgs/flash.png'),
                                    // inactiveImage: AssetImage('imgs/energy.png'),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    width: 63.0,
                                    height: 30.0,
                                    enabled: true,
                                    disabledOpacity: 0.5,
                                  )),
                            ),
// ...
                          ],
                        )),
                  ),

                  ////Home Screen Widget
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 15,
                    ),
                    child: Container(
                        width: 1.sw,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              12), // Adjust the radius for circular edges
                          color: const Color(
                              0xffffffff), // Set your desired background color
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Home Screen Widget",
                                style: TextStyle(
                                  color: Color(0xffADAFBD),
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Obx(() => AdvancedSwitch(
                                    activeColor: const Color(0xff4285F4),
                                    inactiveColor: Colors.grey,
                                    activeChild: const Text('ON'),
                                    inactiveChild: const Text('OFF'),
                                    initialValue: controller.showhomepage.value,
                                    onChanged: (value) {
                                      controller.showhomepage.value = value;
                                      setValue(widgetstate, value);
                                    },
                                    // activeImage: AssetImage('imgs/flash.png'),
                                    // inactiveImage: AssetImage('imgs/energy.png'),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    width: 63.0,
                                    height: 30.0,
                                    enabled: true,
                                    disabledOpacity: 0.5,
                                  )),
                            ),
                          ],
                        )),
                  ),

                  //////Download Duplicate Bill

                  InkWell(
                    onTap: () async {
                      await launchUrl(url2);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                      ),
                      child: Container(
                          width: 1.sw,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                12), // Adjust the radius for circular edges
                            color: const Color(
                                0xffffffff), // Set your desired background color
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Download Duplicate Bill",
                                  style: TextStyle(
                                    color: Color(0xffADAFBD),
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("imgs/download_bt.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),

                  ///
                  ////
                  /////
                  ////
                  ///
                  ///
//////////////////////////////////////////////////////////
                  /////////About Us

                  InkWell(
                    onTap: () async {
                      await launchUrl(url);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                      ),
                      child: Container(
                          width: 1.sw,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                12), // Adjust the radius for circular edges
                            color: const Color(
                                0xffffffff), // Set your desired background color
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "About Us",
                                  style: TextStyle(
                                    color: Color(0xffADAFBD),
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 55,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("imgs/logo.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    onTap: () {
                      // Call the signOut method of the AuthController
                      Get.find<AuthController>().signOut(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                      ),
                      child: Container(
                          width: 125,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                22), // Adjust the radius for circular edges
                            color: const Color(
                                0xffffffff), // Set your desired background color
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  width: 19,
                                  height: 17,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("imgs/logout.png"),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Log out",
                                  style: TextStyle(
                                    color: Color(0xff4285F4),
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
                // Your content here
              ),
            ),
          ),

          Expanded(child: Container()),

          const MenuBarSettings(), // Use the MenuBar widget from your custom package with the prefix
        ],
      ),
    );
  }

  // Function to launch URL
}
