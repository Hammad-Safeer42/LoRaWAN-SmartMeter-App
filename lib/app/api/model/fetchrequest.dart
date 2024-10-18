import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_v101/app/functions/getPredictedBillpkr.dart';
import 'package:fyp_v101/app/functions/getPredictedUnits.dart';
import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class HourlyData {
  String deviceId;
  String timestamp;
  String data;

  HourlyData({
    required this.deviceId,
    required this.timestamp,
    required this.data,
  });
}

class DailyData {
  String timestamp;
  String data;

  DailyData({
    required this.timestamp,
    required this.data,
  });
}

class WeeklyData {
  String timestamp;
  String data;

  WeeklyData({
    required this.timestamp,
    required this.data,
  });
}

Future<void> getData(
  String meterid,
  int billStartingDate,
  double unitrate,
  double quaterlyAdjusments,
  double additionalSurcharage,
  double surcharge,
  double electricDuty,
  double salesTax,
  double incometax,
  double tvFee,
  double numOfTVs,
  bool taxExemption,
  double minCharges, {
  String messagetype = 'uplink_message',
  //int limit = 10,
  String fieldMask = 'up.uplink_message.decoded_payload',
}) async {
  HomeController homeController = Get.find();

  final url = Uri.https(
    'retrofit-smart-meter.au1.cloud.thethings.industries',
    '/api/v3/as/applications/test-app/devices/$meterid/packages/storage/$messagetype',
    {
      'field_mask': fieldMask,
      //'after': "2024-04-16T18:00:00Z",
      //'limit': "100",
    },
  );

  const String apitoken = 'asgfsggggggggsfsfsfsfsfsfsfsfsfsfsfsfsfsfIRFN3HCAPQ';

  try {
    Get.showSnackbar(
      const GetSnackBar(
        showProgressIndicator: true,
        title: 'Fetching',
        message: 'Fetching',
      ),
    );

    final result = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apitoken',
        'Accept': 'application/json',
      },
    );

    Get.closeAllSnackbars();

    //print(result.body);

    try {
      List<DailyData?> mostRecentInDayRangeList = List.filled(8, null);
      List<DateTime?> mostRecentInDayRangeTimestampList = List.filled(8, null);
      double curPwrMax = 0.0;
      double temp = 0.0;
      int billStartingDate = 1;

      String monthStartDataString;
      double monthStartEnergyVal = 0.0;
      double predictedUnits = 0.0;
      double predictedBillPkr = 0.0;

      List<DailyData?> mostRecentInWeeksRangeList = List.filled(6, null);
      List<DateTime?> mostRecentInWeekRangeTimestampList = List.filled(6, null);

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

      List<DateTime> daysAgo = [
        DateTime.now().subtract(const Duration(days: 1)),
        DateTime.now().subtract(const Duration(days: 2)),
        DateTime.now().subtract(const Duration(days: 3)),
        DateTime.now().subtract(const Duration(days: 4)),
        DateTime.now().subtract(const Duration(days: 5)),
        DateTime.now().subtract(const Duration(days: 6)),
        DateTime.now().subtract(const Duration(days: 7)),
        DateTime.now().subtract(const Duration(days: 8)),
        DateTime.now().subtract(const Duration(days: 9)),
      ];

      DateTime monthstartingDate =
          DateTime(DateTime.now().year, DateTime.now().month, billStartingDate);

      ////////////////////////////////////////////////////
/////////////////////////////////////////////////////

      List<DateTime> weeksAgo = [
        DateTime.now().subtract(const Duration(days: 7)),
        DateTime.now().subtract(const Duration(days: 14)),
        DateTime.now().subtract(const Duration(days: 21)),
        DateTime.now().subtract(const Duration(days: 28)),
        DateTime.now().subtract(const Duration(days: 35)),
        DateTime.now().subtract(const Duration(days: 42)),
        DateTime.now().subtract(const Duration(days: 49)),
      ];
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

      void getDailyRecentData(
          int index,
          DateTime lowerBound,
          DateTime upperBound,
          bool isValidData,
          DateTime receivedTimeVal,
          String receivedAt,
          String data) {
        if (isValidData &&
            receivedTimeVal.isBefore(upperBound) &&
            receivedTimeVal.isAfter(lowerBound)) {
          if (mostRecentInDayRangeList[index] == null ||
              receivedAt.compareTo(
                      mostRecentInDayRangeTimestampList[index].toString()) >
                  0) {
            // Update the most recent data within the range and its timestamp
            mostRecentInDayRangeList[index] = DailyData(
              timestamp: receivedAt,
              data: data,
            );
            mostRecentInDayRangeTimestampList[index] = receivedTimeVal;
          }
        }
      }

      //////////////////////////////////////////////////////////
      ///

      void getWeeklyRecentData(
          int index,
          DateTime lowerBound,
          DateTime upperBound,
          bool isValidData,
          DateTime receivedTimeVal,
          String receivedAt,
          String data) {
        if (isValidData &&
            receivedTimeVal.isBefore(upperBound) &&
            receivedTimeVal.isAfter(lowerBound)) {
          if (mostRecentInWeeksRangeList[index] == null ||
              receivedAt.compareTo(
                      mostRecentInWeekRangeTimestampList[index].toString()) >
                  0) {
            // Update the most recent data within the range and its timestamp
            mostRecentInWeeksRangeList[index] = DailyData(
              timestamp: receivedAt,
              data: data,
            );
            mostRecentInWeekRangeTimestampList[index] = receivedTimeVal;
          }
        }
      }

      ////////////////////////////////////////////
      ////////////////////////////////////////////

      // Split the response string by newline characters ('\n')
      List<String> lines = result.body.trim().split('\n');

      // Initialize variables to hold the most recent valid data
      String? mostRecentReceivedAt;
      String? mostRecentData;

      String instPwrVal = '';
      String currEnergyVal = '';

      List<double> final24HrsVals = List<double>.generate(13, (index) => 0.0);
      List<double> final7DaysVals = List<double>.generate(10, (index) => 0.0);

      List<double> final5WeeksVals = List<double>.generate(8, (index) => 0.0);
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

      List<HourlyData?> mostRecentInRangeList = List.filled(13, null);
      List<DateTime?> mostRecentInRangeTimestampList = List.filled(13, null);

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
      DateTime twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));
      DateTime fourHoursAgo = DateTime.now().subtract(const Duration(hours: 4));
      DateTime sixHoursAgo = DateTime.now().subtract(const Duration(hours: 6));
      DateTime eightHoursAgo =
          DateTime.now().subtract(const Duration(hours: 8));
      DateTime tenHoursAgo = DateTime.now().subtract(const Duration(hours: 10));
      DateTime tweleveHoursAgo =
          DateTime.now().subtract(const Duration(hours: 12));
      DateTime fourteenHoursAgo =
          DateTime.now().subtract(const Duration(hours: 14));
      DateTime sixteenHoursAgo =
          DateTime.now().subtract(const Duration(hours: 16));
      DateTime eighteenHoursAgo =
          DateTime.now().subtract(const Duration(hours: 18));
      DateTime twentyHoursAgo =
          DateTime.now().subtract(const Duration(hours: 20));
      DateTime twentytwoHoursAgo =
          DateTime.now().subtract(const Duration(hours: 22));
      DateTime twentyfourHoursAgo =
          DateTime.now().subtract(const Duration(hours: 24));

      DateTime twentysixHourAgo =
          DateTime.now().subtract(const Duration(hours: 24));

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
      // Iterate over each line in the response
      // Iterate over each line in the response
      for (String line in lines) {
        try {
          // Parse the JSON string into a Dart object
          Map<String, dynamic>? jsonData = json.decode(line);

          // Check if jsonData is not null and contains the expected keys
          if (jsonData != null &&
              jsonData.containsKey('result') &&
              jsonData['result'] is Map<String, dynamic>) {
            Map<String, dynamic> resultData = jsonData['result'];

            // Access data from the JSON object
            String deviceId = resultData['end_device_ids']['device_id'] ?? '';
            String receivedAt = resultData['received_at'] ?? '';
            String data =
                resultData['uplink_message']['decoded_payload']['data'] ?? '';

            String receivedAtString = resultData['received_at'] ?? '';
            DateTime receivedTimeVal = DateTime.parse(receivedAtString);

            // Check if the data meets your criteria
            List<String> values =
                data.split(',').map((value) => value.trim()).toList();

            // Print parsed values for debugging
            // print('Parsed Values: $values');

            // Continue processing only if there are at least 3 values
            if (values.length >= 3) {
              bool isValidData = values.take(3).every((value) =>
                  double.tryParse(value) != null && double.parse(value) > 0);

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(twoHoursAgo) &&
                  receivedTimeVal.isAfter(fourHoursAgo)) {
                if (mostRecentInRangeList[0] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[0].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[0] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[0] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(fourHoursAgo) &&
                  receivedTimeVal.isAfter(sixHoursAgo)) {
                if (mostRecentInRangeList[1] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[1].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[1] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[1] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(sixHoursAgo) &&
                  receivedTimeVal.isAfter(eightHoursAgo)) {
                if (mostRecentInRangeList[2] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[2].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[2] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[2] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(eightHoursAgo) &&
                  receivedTimeVal.isAfter(tenHoursAgo)) {
                if (mostRecentInRangeList[3] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[3].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[3] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[3] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(tenHoursAgo) &&
                  receivedTimeVal.isAfter(tweleveHoursAgo)) {
                if (mostRecentInRangeList[4] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[4].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[4] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[4] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(tweleveHoursAgo) &&
                  receivedTimeVal.isAfter(fourteenHoursAgo)) {
                if (mostRecentInRangeList[5] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[5].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[5] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[5] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(fourteenHoursAgo) &&
                  receivedTimeVal.isAfter(sixteenHoursAgo)) {
                if (mostRecentInRangeList[6] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[6].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[6] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[6] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(sixteenHoursAgo) &&
                  receivedTimeVal.isAfter(eighteenHoursAgo)) {
                if (mostRecentInRangeList[7] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[7].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[7] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[7] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(eighteenHoursAgo) &&
                  receivedTimeVal.isAfter(twentyHoursAgo)) {
                if (mostRecentInRangeList[8] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[8].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[8] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[8] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(twentyHoursAgo) &&
                  receivedTimeVal.isAfter(twentytwoHoursAgo)) {
                if (mostRecentInRangeList[9] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[9].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[9] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[9] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(twentytwoHoursAgo) &&
                  receivedTimeVal.isAfter(twentyfourHoursAgo)) {
                if (mostRecentInRangeList[10] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[10].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[10] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[10] = receivedTimeVal;
                }
              }

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
              if (isValidData &&
                  receivedTimeVal.isBefore(twentyfourHoursAgo) &&
                  receivedTimeVal.isAfter(twentysixHourAgo)) {
                if (mostRecentInRangeList[11] == null ||
                    receivedAt.compareTo(
                            mostRecentInRangeTimestampList[11].toString()) >
                        0) {
                  // Update the most recent data within the range and its timestamp
                  mostRecentInRangeList[11] = HourlyData(
                    deviceId: deviceId,
                    timestamp: receivedAt,
                    data: data,
                  );
                  mostRecentInRangeTimestampList[11] = receivedTimeVal;
                }
              }
/////////////////////////////////////////////////////////////////////////////
//////////////////////////////     days    //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

              getDailyRecentData(
                  7, // int index
                  daysAgo[1], // DateTime lowerBound
                  daysAgo[0], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getDailyRecentData(
                  6, // int index
                  daysAgo[2], // DateTime lowerBound
                  daysAgo[1], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getDailyRecentData(
                  5, // int index
                  daysAgo[3], // DateTime lowerBound
                  daysAgo[2], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getDailyRecentData(
                  4, // int index
                  daysAgo[4], // DateTime lowerBound
                  daysAgo[3], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getDailyRecentData(
                  3, // int index
                  daysAgo[5], // DateTime lowerBound
                  daysAgo[4], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getDailyRecentData(
                  2, // int index
                  daysAgo[6], // DateTime lowerBound
                  daysAgo[5], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getDailyRecentData(
                  1, // int index
                  daysAgo[7], // DateTime lowerBound
                  daysAgo[6], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getDailyRecentData(
                  0, // int index
                  daysAgo[8], // DateTime lowerBound
                  daysAgo[7], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////     weeks    //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

              getWeeklyRecentData(
                  5, // int index
                  weeksAgo[1], // DateTime lowerBound
                  weeksAgo[0], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getWeeklyRecentData(
                  4, // int index
                  weeksAgo[2], // DateTime lowerBound
                  weeksAgo[1], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getWeeklyRecentData(
                  3, // int index
                  weeksAgo[3], // DateTime lowerBound
                  weeksAgo[2], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getWeeklyRecentData(
                  2, // int index
                  weeksAgo[4], // DateTime lowerBound
                  weeksAgo[3], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getWeeklyRecentData(
                  1, // int index
                  weeksAgo[5], // DateTime lowerBound
                  weeksAgo[4], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              getWeeklyRecentData(
                  0, // int index
                  weeksAgo[6], // DateTime lowerBound
                  weeksAgo[5], // DateTime upperBound
                  isValidData, // bool isValidData
                  receivedTimeVal, // DateTime receivedTimeVal
                  receivedAt, // String receivedAt
                  data // String data
                  );

              ////////////////////////////////////////////////////////////////////////////////////////
              ////////////////////////////////////////////////////////////////////////////////////////
              //////                                                                           ///////
              ///                     get valid value, on 1st/ specified starting date           /////
              //////                                                                           ///////
              ////////////////////////////////////////////////////////////////////////////////////////
              ////////////////////////////////////////////////////////////////////////////////////////

              if (isValidData && receivedTimeVal.isBefore(monthstartingDate)) {
                if (receivedAt.compareTo((monthstartingDate).toString()) > 0) {
                  // Update the most recent data within the range and its timestamp

                  monthStartDataString = data;

                  List<String> tempsplitList = monthStartDataString.split(',');

                  if (tempsplitList.length >= 2) {
                    monthStartEnergyVal =
                        tempsplitList[0].toDouble(); // First value
                  }
                }
              }

/////////////////////////////////////////////////////////////////////////////////////////////////////
              if (isValidData) {
                List<String> templist = (resultData['uplink_message']
                            ['decoded_payload']['data'] ??
                        '')
                    .split(',');

                if (templist.length >= 2) {
                  temp = templist[1].toDouble(); // First value

                  if (temp > curPwrMax) {
                    curPwrMax = temp;
                  }
                }
              }

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
              // Update most recent data if it meets the criteria and is more recent
              if (isValidData &&
                  (mostRecentReceivedAt == null ||
                      receivedAt.compareTo(mostRecentReceivedAt) > 0)) {
                mostRecentReceivedAt = receivedAt;
                mostRecentData = data;
              }
            }
          }
        } catch (e) {
          // Handle JSON decoding errors
        }
      }

      if (mostRecentData != null) {
        List<String> values = mostRecentData.split(',');
        // String singleVal = '';

        if (values.length >= 2) {
          instPwrVal = values[1]; // First value
          currEnergyVal = values[0]; // Second value
        }
      } else {
        instPwrVal = '0.0'; // First value
        currEnergyVal = '0.0';
      }
/////////////////////////////////////////////////////////
      ///???????????????  PRedicted Values  //////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////

      predictedUnits = await getPredictedUnits(
          monthStartEnergyVal,
          currEnergyVal.toDouble(),
          DateTime.parse(mostRecentReceivedAt!),
          monthstartingDate);

      ///

      predictedBillPkr = await getPredictedBillpkr(
          unitrate,
          predictedUnits,
          quaterlyAdjusments,
          additionalSurcharage,
          surcharge,
          electricDuty,
          salesTax,
          incometax,
          tvFee,
          numOfTVs,
          taxExemption,
          minCharges);

      /////////////////////////////////////////////////////
      ///    parsing predicted values to controllers   ////
      //////////////////////////////////////////////// ////

      homeController.predictedPkr = predictedBillPkr.ceil().toInt();

      homeController.predictedUnit = predictedUnits.ceil().toInt();

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////

      for (int i = 0; i < 13; i++) {
        if (mostRecentInRangeList[i] != null) {
          List<String> last24HrsVals =
              mostRecentInRangeList[i]!.data.split(',');

          if (last24HrsVals.length >= 2) {
            final24HrsVals[i] = (last24HrsVals[1].toDouble() * 10).ceil() / 10;
          }
        } else {
          final24HrsVals[i] = 0.0;
        }
      }
//////////////////////////////////////////
/////////////////  DAYS  ///////////////////
///////////////////////////////////////////////

      for (int i = 0; i < 8; i++) {
        if (mostRecentInDayRangeList[i] != null) {
          List<String> last7DaysVals =
              mostRecentInDayRangeList[i]!.data.split(',');

          if (last7DaysVals.length >= 2) {
            final7DaysVals[i] = (last7DaysVals[0].toDouble() * 10).ceil() / 10;
          }
        } else {
          final7DaysVals[i] = 0.0;
        }
      }

//////////////////////////////////////////
/////////////////  weeks  ///////////////////
///////////////////////////////////////////////

      for (int i = 0; i < 6; i++) {
        if (mostRecentInWeeksRangeList[i] != null) {
          List<String> last5WeeksVals =
              mostRecentInWeeksRangeList[i]!.data.split(',');

          if (last5WeeksVals.length >= 2) {
            final5WeeksVals[i] =
                (last5WeeksVals[0].toDouble() * 10).ceil() / 10;
          }
        } else {
          final5WeeksVals[i] = 0.0;
        }
      }

/////////////////////////////////////////////////////////////////////
///////////////////                                 /////////////////
//////////////////    days differences calculations /////////////////
//////////////////                                  /////////////////
/////////////////////////////////////////////////////////////////////
      List<double> daysValuesDiff = List<double>.filled(10, 0.0);

      for (int i = 0; i < 8; i++) {
        double difference = final7DaysVals[i + 1] - final7DaysVals[i];
        if (difference < 0.5 || difference > 100) {
          daysValuesDiff[i] = 0;
        } else {
          daysValuesDiff[i] = difference;
        }
      }

      ////////////////////////////////////////////////////////
      ////////////////////////////////////////////////////////

      homeController.past7DaysValues = daysValuesDiff;

////////////////////////////////////////////////////////////////////
///////////////////                                 /////////////////
//////////////////    weeks differences calculations /////////////////
//////////////////                                  /////////////////
/////////////////////////////////////////////////////////////////////
      List<double> weeksValuesDiff = List<double>.filled(10, 0.0);

      for (int i = 0; i < 6; i++) {
        double difference = final5WeeksVals[i + 1] - final5WeeksVals[i];
        if (difference < 0.5) {
          weeksValuesDiff[i] = 0;
        } else {
          weeksValuesDiff[i] = difference;
        }
      }

      ////////////////////////////////////////////////////////
      ////////////////////////////////////////////////////////

      homeController.past5WeeksValues = weeksValuesDiff;

//////////////////////////////////////////////
      ///       Parsing values to linechart for past 24 hrs
      ///
      homeController.past24Hrsvalues = final24HrsVals;

////////////////////////////////////////////////////////////
      ///       parsing istantenous values
      ///
      // Retrieve the instance of HomeController
      homeController.instPwrW = instPwrVal.toDouble();

      homeController.currentUnits = (currEnergyVal.toDouble() * 10).ceil() / 10;

      ///////////////////////////////////////////////
      ///////////////////////////////////////////////////
      // current month max Power

      //////////////////////// this is for testing, ///////////this will be removed in future
      if (curPwrMax > 6) {
        homeController.currMonthPwrMax =
            ((curPwrMax - curPwrMax / 2) * 10).ceil() / 10;
      } else {
        homeController.currMonthPwrMax = ((curPwrMax) * 10).ceil() / 10;
      }

      ///////////////////////////////////////////////////
      ///////////////////////////////////////////////////
    } catch (e) {
      // Handle errors

      Get.closeAllSnackbars();
      debugPrint(e.toString());
    }
  } catch (e) {
    Get.closeAllSnackbars();
    debugPrint(e.toString());
  }
}
