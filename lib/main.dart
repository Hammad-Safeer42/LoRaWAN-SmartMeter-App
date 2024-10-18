import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fyp_v101/app/api/model/getHomeWidgetData.dart';
import 'package:fyp_v101/app/functions/notificationservices.dart';
import 'package:fyp_v101/firebase_options.dart';
import 'package:fyp_v101/splash.view.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'app/routes/app_pages.dart';

import "package:home_widget/home_widget.dart";

// Home WIgdet Function
const _unitKey = 'units';
const _wattsKey = 'kwatts';

Future<int> _increment() async {
  try {
    await initialize();
  } catch (_) {}

  var meterid = getStringAsync("meterid", defaultValue: 'meterid');

  if (meterid != 'meterid') {
    var data = await getHomeWidgetData(meterid);
    if (data.isNotEmpty) {
      await _sendAndUpdate(data['unit'], data['watts']);
    }
  }

  return 0;
}

/// Clears the saved Counter Value
Future<void> _clear() async {
  await _sendAndUpdate(null);
}

/// Stores [value] in the Widget Configuration
Future<void> _sendAndUpdate([String? unit, String? watts]) async {
  await HomeWidget.saveWidgetData(_unitKey, unit);
  await HomeWidget.saveWidgetData(_wattsKey, watts);
  await HomeWidget.updateWidget(
    name: "SmartHomeWidget",
    androidName: 'SmartHomeWidget',
  );
}

@pragma('vm:entry-point')
Future<void> interactiveCallback(Uri? uri) async {
  // We check the host of the uri to determine which action should be triggered.
  if (uri?.host == 'increment') {
    await _increment();
  } else if (uri?.host == 'clear') {
    await _clear();
  }
}

////////////
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await initialize();

  NotificationManager.init();

  await HomeWidget.setAppGroupId('SmartGroupID');
  // Register an Interactivity Callback. It is necessary that this method is static and public
  await HomeWidget.registerInteractivityCallback(interactiveCallback);

  runApp(
    ScreenUtilInit(
        designSize: const Size(390, 770),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "The Smart",
            getPages: AppPages.routes,
            home: const SplashView(),
          );
        }),
  );
}
