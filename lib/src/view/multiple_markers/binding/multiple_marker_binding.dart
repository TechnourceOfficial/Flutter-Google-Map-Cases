import 'package:get/get.dart';

import '../controller/multiple_marker_controller.dart';

class MultipleMarkerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultipleMarkerController>(() => MultipleMarkerController());
  }
}
