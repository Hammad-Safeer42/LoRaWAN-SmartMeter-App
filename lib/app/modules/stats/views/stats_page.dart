import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/ui/component/yearly_barGraph.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ui/component/menu_bar_stats.dart';

class StatsPage extends GetView<HomeController> {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri _url2 = Uri.parse(controller.auth.appdata.value!.duplicateBill);

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
                          CircleAvatar(
                            radius: 28,
                            child: ClipOval(
                              child: Image.network(
                                controller.auth.userdata.value!.image
                                    .validate(),
                                fit: BoxFit.cover,
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
                'Yearly Consumption',
                style: TextStyle(
                    fontFamily: 'lato',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff363B64)),
              ),
            ),
          ),

/////////////////////////////////////////////////////////////

          YearlyBarChart(),

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
                height: 0.40.sh,
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
                        right: 10,
                        top: 5,
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
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 9),
                                child: SizedBox(
                                  width: 1.sw - 60,
                                  height: 120,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10), // Adjust the radius for circular edges
                                      color: Colors
                                          .white, // Set your desired background color
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, top: 10),
                                              child: Text(
                                                "Last month Bill",
                                                style: TextStyle(
                                                  color: Color(0xffADAFBD),
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, top: 10),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "Units:",
                                                    style: TextStyle(
                                                      color: Color(0xffADAFBD),
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 13),
                                                  Text(
                                                    (controller.auth.userdata
                                                                .value?.extra[
                                                            'lastMonthBillunits'] ??
                                                        '0.0'),
                                                    style: const TextStyle(
                                                      color: Color(0xff3A57E8),
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, top: 5),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "Bill:",
                                                    style: TextStyle(
                                                      color: Color(0xffADAFBD),
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 25),
                                                  Text(
                                                    controller.auth.userdata
                                                                .value?.extra[
                                                            'lastMonthBillpkr'] ??
                                                        '0.0',
                                                    style: const TextStyle(
                                                      color: Color(0xff3A57E8),
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  const Text(
                                                    "PKR",
                                                    style: TextStyle(
                                                      color: Color(0xffADAFBD),
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                await launchUrl(_url2);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 90, top: 17),
                                                child: SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: Container(
                                                    color: Colors
                                                        .white, // Set your desired background color
                                                    child: Image.asset(
                                                      'imgs/download_bt.png',
                                                      fit: BoxFit
                                                          .cover, // Adjust the fit as needed
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 35),
                                                  child: Text(
                                                    "Status:",
                                                    style: TextStyle(
                                                      color: Color(0xffADAFBD),
                                                      fontFamily: 'Lato',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: controller
                                                                  .auth
                                                                  .userdata
                                                                  .value
                                                                  ?.extra[
                                                              'lastBillStatus'] ??
                                                          false
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 30),
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                  width: 15),
                                                              const Text(
                                                                "Paid",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    0xff06a94d,
                                                                  ),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .white,
                                                                  child: Image
                                                                      .asset(
                                                                    'imgs/ispaidTick.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 30),
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Text(
                                                                "Unpaid",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                    0xFFff2c2c,
                                                                  ),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .white,
                                                                  child: Image
                                                                      .asset(
                                                                    'imgs/unpaidCross.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Widgets for the case when isPaid is false
                                                            ],
                                                          ),
                                                        ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 160,
                                      height: 150,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10), // Adjust the radius for circular edges
                                            color: Colors
                                                .white, // Set your desired background color
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15, top: 10),
                                                  child: Text(
                                                    'Max Power',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          107, 28, 28, 29),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 90,
                                                        child: Container(
                                                          color: Colors.white,
                                                          child: Image.asset(
                                                            'imgs/flash.png',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 12,
                                                          ),
                                                          child: Text(
                                                            'Curr. month',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'lato',
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromARGB(
                                                                      107,
                                                                      28,
                                                                      28,
                                                                      29),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 15),
                                                              child: Text(
                                                                controller
                                                                    .currMonthPwrMax
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xff3A57E8),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 02,
                                                              ),
                                                              child: Text(
                                                                'kW',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF363B64),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 12,
                                                                  top: 0),
                                                          child: Text(
                                                            'Last month',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      107,
                                                                      28,
                                                                      28,
                                                                      29),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 15),
                                                              child: Text(
                                                                controller
                                                                        .auth
                                                                        .userdata
                                                                        .value
                                                                        ?.extra['lastMonthMax'] ??
                                                                    '0.0',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xff3A57E8),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 02,
                                                              ),
                                                              child: Text(
                                                                'kW',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF363B64),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                ),
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
                                          )),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 160,
                                      height: 150,
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
                                              padding: EdgeInsets.only(
                                                  bottom: 5, top: 10),
                                              child: Text(
                                                'Curr. Meter Reading',
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10, top: 5),
                                                      child: SizedBox(
                                                        width: 70,
                                                        height: 80,
                                                        child: Container(
                                                          color: Colors
                                                              .white, // Set your desired background color
                                                          child: Image.asset(
                                                            'imgs/meter_icon.png',
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
                                                    ////////////////////

                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 20),
                                                            child: Text(
                                                              ((controller.currentUnits ??
                                                                          0) +
                                                                      (controller
                                                                              .auth
                                                                              .userdata
                                                                              .value
                                                                              ?.extra['initialMeterReading'] ??
                                                                          0))
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xff3A57E8),
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                            ],
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 7,
          ),

          // Expanded(child: Container()),

          MenuBarStats(), // Use the MenuBar widget from your custom package with the prefix
        ],
      ),
    );
  }
}
