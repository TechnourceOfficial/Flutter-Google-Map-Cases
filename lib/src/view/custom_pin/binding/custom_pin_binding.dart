import 'package:get/get.dart';

import '../controller/custom_pin_controller.dart';

class CustomPinBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CustomPinController>(() => CustomPinController());
  }
}