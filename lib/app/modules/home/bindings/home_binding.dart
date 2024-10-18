import 'package:get/get.dart';

import 'package:fyp_v101/app/modules/home/controllers/services_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(
      () => ServicesController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
