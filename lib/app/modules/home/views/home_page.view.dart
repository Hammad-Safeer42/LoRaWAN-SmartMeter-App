import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_v101/app/api/model/fetchrequest.dart';
import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/ui/component/chartSelector_home.dart';
import 'package:fyp_v101/app/ui/component/menu_bar_home.dart';
import 'package:fyp_v101/app/ui/component/toggleButtonState.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: 1.sw,
            height: 0.18.sh,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("imgs/home_top.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi ${controller.auth.userdata.value?.fullName}',
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color(0xFF333333),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Acc No: ${controller.auth.userdata.value?.accountId}',
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  color: Color(0xFF4285F4),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await getData(
                                  controller.auth.userdata.value!.meterId,
                                  controller.auth.appdata.value!
                                      .extra["billStartingDate"],
                                  controller
                                      .auth.appdata.value!.extra["unitRate"],
                                  controller.auth.appdata.value!
                                      .extra["quarterlyAdjustments"]
                                      .toDouble(),
                                  controller.auth.appdata.value!
                                      .extra["aditionalSurcharge"]
                                      .toDouble(),
                                  controller
                                      .auth.appdata.value!.extra["surcharges"]
                                      .toDouble(),
                                  controller.auth.appdata.value!
                                      .extra["electricityDuty"]
                                      .toDouble(),
                                  controller.auth.appdata.value!.extra["salesTax"]
                                      .toDouble(),
                                  controller.auth.appdata.value!.extra["incomeTax"]
                                      .toDouble(),
                                  controller.auth.appdata.value!.extra["tvfee"]
                                      .toDouble(),
                                  controller
                                      .auth.userdata.value!.extra["numOfTVs"]
                                      .toDouble(),
                                  controller.auth.userdata.value!
                                      .extra["taxExemption"],
                                  controller
                                      .auth.appdata.value!.extra["minCharges"]
                                      .toDouble());
                            },
                            child: CircleAvatar(
                              radius: 28,
                              child: ClipOval(
                                child: Image.network(
                                  controller.auth.userdata.value!.image
                                      .validate(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /////////////////////////////////////////////
          ///
          ///      energy usage part ( line grapgh)
          ///
          ///
          ///??????????????????????????????????????????????

          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Energy Usage',
                style: TextStyle(
                    fontFamily: 'lato',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff363B64)),
              ),
            ),
          ),

/////////////////////////////////////////////////////////////
          const ToggleButtonState(),

          const SelectedLineChartWidget(),

          //linechartHomePage1(),

          //linechartHomePage2

          /////////////////////////////////////////////////////////////

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Container(
          //     width: w,
          //     height: 240,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(
          //           10), // Adjust the radius for circular edges
          //       color: Color.fromARGB(
          //           9, 159, 175, 202), // Set your desired background color
          //     ),

          //   ),

          // ),

          Expanded(child: Container()),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: 1.sw,
                height: 0.42.sh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10), // Adjust the radius for circular edges
                  color: const Color.fromARGB(
                      54, 159, 175, 202), // Set your desired background color
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Details',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Color(0xFF363B64),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Container(
                        height: 10,
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 170,
                                height: 155,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius for circular edges
                                    color: Colors
                                        .white, // Set your desired background color
                                  ),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(
                                          'Current month Units',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  107, 28, 28, 29)),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, top: 25),
                                            child: SizedBox(
                                              width: 65,
                                              height: 70,
                                              child: Container(
                                                color: Colors
                                                    .white, // Set your desired background color
                                                child: Image.asset(
                                                  'imgs/bolt_home.png',
                                                  fit: BoxFit
                                                      .cover, // Adjust the fit as needed
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 25),
                                            child: SizedBox(
                                              width: 3,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 25),
                                            child: Text(
                                              controller.currentUnits
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color(0xFF363B64),
                                                fontFamily: 'Lato',
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 3, top: 25),
                                            child: Text(
                                              'Units',
                                              style: TextStyle(
                                                  color: Color(0xFF363B64),
                                                  fontFamily: 'Lato',
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ///////////////////////////
                            ///
                            ///
                            ///
                            ///   LAST BILL view
                            ///
                            ///
                            ///
                            ///////////////////////////
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 170,
                                height: 110,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius for circular edges
                                    color: Colors
                                        .white, // Set your desired background color
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Container(
                                              color: Colors
                                                  .white, // Set your desired background color
                                              child: Image.asset(
                                                'imgs/previous_month_home.png',
                                                fit: BoxFit
                                                    .cover, // Adjust the fit as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, top: 28),
                                              child: Text(
                                                controller.auth.userdata.value!
                                                            .extra[
                                                        'lastMonthBillpkr'] ??
                                                    '0.0',
                                                style: const TextStyle(
                                                  color: Color(0xFF057718),
                                                  fontFamily: 'Lato',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                left: 5,
                                              ),
                                              child: Text(
                                                'Last  Bill',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      107, 28, 28, 29),
                                                  fontFamily: 'Lato',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 4, top: 40),
                                            child: Text(
                                              'PKR',
                                              style: TextStyle(
                                                  color: Color(0xFF363B64),
                                                  fontFamily: 'Lato',
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(
                                      10.0), // Adjust the radius as needed
                                ),
                                child: Container(
                                  width: 170,
                                  height: 22,
                                  color: Colors
                                      .white, // Set your desired background color
                                  // Your content here
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Container(
                          child: SizedBox(
                            height: 5,
                          ),
                        )),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: SizedBox(
                                width: 170,
                                height: 110,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius for circular edges
                                    color: Colors
                                        .white, // Set your desired background color
                                  ),

                                  //////////////??
                                  ///
                                  ///
                                  ///   INT PWR
                                  ///
                                  ///
                                  ///
                                  ///????????/////

                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 65,
                                          width: 65,
                                          child: CircularPercentIndicator(
                                            radius: 55,
                                            lineWidth: 7,
                                            percent: controller.instPwrPrcntInd,
                                            progressColor: const Color.fromARGB(
                                                255, 57, 87, 236),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    28, 0, 123, 255),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            center: SizedBox(
                                              width: 19,
                                              height: 19,
                                              child: Container(
                                                color: Colors
                                                    .white, // Set your desired background color
                                                child: Image.asset(
                                                  'imgs/arrow-upper-right.png',
                                                  fit: BoxFit
                                                      .cover, // Adjust the fit as needed
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 35),
                                                  child: Text(
                                                    controller.instPwrW
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF363B64),
                                                      fontFamily: 'Lato',
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 3, top: 35),
                                                  child: Text(
                                                    'kW',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF363B64),
                                                        fontFamily: 'Lato',
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              'Inst. Power',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    107, 28, 28, 29),
                                                fontFamily: 'Lato',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ////              ////
                            ///               ////
                            ///Predicted bill ////
                            ///               ////
                            ///               ////
                            ///

                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 170,
                                height: 155,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius for circular edges
                                    color: Colors.white,
                                    // Set your desired background color
                                  ),
                                  child: Column(
                                    children: [
                                      ///////////////////
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 5, top: 15),
                                        child: Text(
                                          'Predicted  Bill',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  107, 28, 28, 29)),
                                        ),
                                      ),

                                      ///////////////////
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: SizedBox(
                                                  width: 55,
                                                  height: 57,
                                                  child: Container(
                                                    color: Colors
                                                        .white, // Set your desired background color
                                                    child: Image.asset(
                                                      'imgs/forecast_home.png',
                                                      fit: BoxFit
                                                          .cover, // Adjust the fit as needed
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 3, top: 15),
                                                    child: SizedBox(
                                                      width: 3,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Text(
                                                      controller.predictedUnit
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF3A57E8),
                                                        fontFamily: 'Lato',
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5, top: 20),
                                                    child: Text(
                                                      'Units',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF363B64),
                                                          fontFamily: 'Lato',
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              ////////////////////

                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 35),
                                                  ),
                                                  Text(
                                                    controller.predictedPkr
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF007AFF),
                                                      fontFamily: 'Lato',
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 3, top: 5),
                                                    child: Text(
                                                      'PKR',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF363B64),
                                                          fontFamily: 'Lato',
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(
                                      10.0), // Adjust the radius as needed
                                ),
                                child: Container(
                                  width: 170,
                                  height: 22,
                                  color: Colors
                                      .white, // Set your desired background color
                                  // Your content here
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(child: Container()),

          const MenuBarHome(), // Use the MenuBar widget from your custom package with the prefix
        ],
      ),
    );
  }
}
