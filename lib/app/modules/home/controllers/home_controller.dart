import 'package:fyp_v101/app/api/model/getHomeWidgetData.dart';
import 'package:fyp_v101/app/data/commonkeys.dart';
import 'package:fyp_v101/app/functions/notificationservices.dart';
import 'package:fyp_v101/app/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeController extends GetxController {
  double currentUnits = 0.0;
  double currentW = 0.0;
  double instPwrW = 0.00;

  List<double> past24Hrsvalues = [
    0.7,
    1.0,
    2.3,
    2.6,
    1.1,
    1.4,
    2.9,
    0.3,
    1.2,
    1.4,
    2.2,
    1.0,
    0.8,
  ];
  List<double> past7DaysValues = [15, 11, 13, 12, 14, 11, 16, 14, 12, 11, 0];
  List<double> past5WeeksValues = [15, 11, 13, 12, 14, 0];

  int predictedPkr = 0;
  int lastBillPkr = 15765;
  int predictedUnit = 0;

  double instPwrPrcntInd = 0.65;
  double prcntIndMaxVal = 10;

  var selectedButton = 'Hours'.obs;
  var isNotificationEnabled = false.obs;

/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
/////////////      STaTS PAGE/////////////
  double lastMonthPwrMax = 1.32;
  double currMonthPwrMax = 1.5;

  int currMeterReading = 124323;

  int lastBillUnits = 543;

  var isPaid = false.obs;
  var showhomepage = false.obs;

  @override
  void onInit() async {
    isNotificationEnabled.value =
        getBoolAsync(dailyUsageNotification, defaultValue: false);
    showhomepage.value = getBoolAsync(widgetstate, defaultValue: false);

    var meterID = getStringAsync("meterid", defaultValue: 'meterid');

    if (isNotificationEnabled.value) {
      if (meterID != 'meterid') {
        var recentResponseApi = await getHomeWidgetData(meterID);

        if (recentResponseApi.isNotEmpty) {
          NotificationManager.scheduledNotification('The Smart',
              'Yesterday Energy usage was ${recentResponseApi["unit"]} kWh');
        }
      }
    } else {}
    super.onInit();
  }

  void toggleButtonState(String buttonName) {
    selectedButton.value = buttonName; // Update the selected button
  }

  var auth = Get.find<AuthController>();
  void setButton(String s) {
    selectedButton.value = s;
  }
}
