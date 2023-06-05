import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../global/utils/utils.dart';

class HomeController extends GetxController {
  @override
  void onReady() async {
    if (await Utils.haveLocationPermission()) {
      debugPrint('true');
    } else {
      debugPrint('false');
    }
    super.onReady();
  }
}
