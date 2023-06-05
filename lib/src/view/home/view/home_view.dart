import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/global/utils/config.dart';
import 'package:google_map_modules/src/routes/app_pages.dart';

import '../../../../global/constants/resources/resources.dart';
import '../../../../global/utils/utils.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Config.appName)),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [buildRow1(), buildRow2()])),
        ));
  }

  buildRow1() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildSearchLocationButton(),
      const SizedBox(width: 15),
      buildMultipleMarkers()
    ]);
  }

  buildRow2() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildRouteDrawButton(),
      const SizedBox(width: 15),
      buildClusterButton()
    ]);
  }

  buildClusterButton() {
    return Expanded(
        child: ElevatedButton(
            onPressed: () => Get.toNamed(Routes.clusterView),
            child: Text(R.strings.ksCluster)));
  }

  buildRouteDrawButton() {
    return Expanded(
      child: ElevatedButton(
          onPressed: () async {
            if (await Utils.haveLocationPermission()) {
              Get.toNamed(Routes.routeDrawView);
            }
          },
          child: Text(R.strings.ksRouteDraw)),
    );
  }

  buildMultipleMarkers() {
    return Expanded(
      child: ElevatedButton(
          onPressed: () async {
            if (await Utils.haveLocationPermission()) {
              Get.toNamed(Routes.multipleMarkerView);
            }
          },
          child: Text(R.strings.ksMultipleMarkers)),
    );
  }

  buildSearchLocationButton() {
    return Expanded(
      child: ElevatedButton(
          onPressed: () async {
            if (await Utils.haveLocationPermission()) {
              Get.toNamed(Routes.searchLocationView);
            }
          },
          child: Text(R.strings.ksSearchLocation)),
    );
  }
}
