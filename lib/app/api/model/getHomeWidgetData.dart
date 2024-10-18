// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

Future<Map<String, dynamic>> getHomeWidgetData(
  String meterid, {
  String messagetype = 'uplink_message',
  //int limit = 10,
  String fieldMask = 'up.uplink_message.decoded_payload',
}) async {
  final url = Uri.https(
    'retrofit-smart-meter.au1.cloud.thethings.industries',
    '/api/v3/as/applications/test-app/devices/$meterid/packages/storage/$messagetype',
    {
      'field_mask': fieldMask,
      //'after': "2024-04-16T18:00:00Z",
      //'limit': "100",
    },
  );

  const String apitoken =
      'NNSXS.MOMPH5GDAIGCT2RRNOFTTQXZWO2SMYNWGXIVKBY.DPZDCWDP3EI4FNLIU62G6E6BG6MGPGRWMX656X64DYIRFN3HCAPQ';

  try {
    final result = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apitoken',
        'Accept': 'application/json',
      },
    );

    try {
      List<String> lines = result.body.trim().split('\n');

      String? mostRecentReceivedAt;
      String? mostRecentData;

      String instPwrVal = '';
      String currEnergyVal = '';

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
            String receivedAt = resultData['received_at'] ?? '';
            String data =
                resultData['uplink_message']['decoded_payload']['data'] ?? '';

            List<String> values =
                data.split(',').map((value) => value.trim()).toList();
            // Print parsed values for debugging
            // print('Parsed Values: $values');

            // Continue processing only if there are at least 3 values
            if (values.length >= 3) {
              bool isValidData = values.take(3).every((value) =>
                  double.tryParse(value) != null && double.parse(value) > 0);

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
          return {};
        }
      }

      if (mostRecentData != null) {
        List<String> values = mostRecentData.split(',');

        if (values.length >= 2) {
          instPwrVal = values[1]; // First value
          currEnergyVal = values[0]; // Second value
        } else {
          return {};
        }
      } else {
        instPwrVal = '0.0'; // First value
        currEnergyVal = '0.0';
      }

      var instPwrW = instPwrVal.toDouble();

      var currentUnits = (currEnergyVal.toDouble() * 10).ceil() / 10;
      return {'unit': currentUnits.toString(), 'watts': "$instPwrW kW"};
    } catch (e) {
      return {};
    }
  } catch (e) {
    return {};
  }
}
