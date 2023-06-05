import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/global/utils/config.dart';
import 'package:google_map_modules/src/routes/app_pages.dart';
import 'package:google_map_modules/src/view/multiple_markers/controller/multiple_marker_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../global/constants/resources/resources.dart';

class MultipleMarkerView extends GetView<MultipleMarkerController> {
  const MultipleMarkerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(R.strings.ksMultipleMarkers), actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                  value: 0, child: Text(R.strings.ksCustomPinTitle))
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Get.toNamed(Routes.customPinView)!.then((value) {
                if (Config.pinIndex.isNotEmpty) {
                  controller.retrieveNearbyRestaurants(
                      controller.currentLocation.value, Config.placeType);
                }
              });
            }
          })
        ]),
        body: Config.kGoogleApiKey.contains(R.strings.putYourAPIKeyHere)
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(R.strings.putYourAPIKeyMsg,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: R.styles.black18600),
                ),
              )
            : Obx(() => controller.markers.isNotEmpty
                ? Stack(children: [
                    buildGoogleMap(),
                    buildFilterRow(),
                    buildInfoWindow()
                  ])
                : const Center(child: CircularProgressIndicator())));
  }

  buildGoogleMap() {
    return Obx(() {
      return GoogleMap(
          onMapCreated: controller.onMapCreated,
          initialCameraPosition: CameraPosition(
              target: controller.currentLocation.value, zoom: 14.0),
          markers: controller.markers);
    });
  }

  buildRestaurantButton() {
    return Expanded(child: Obx(() {
      return ElevatedButton(
          onPressed: () {
            controller.changeRestaurantBtnColor.value = true;
            controller.retrieveNearbyRestaurants(
                controller.currentLocation.value,
                R.strings.ksSelectedPlaceRestaurant);
          },
          style: ButtonStyle(
              backgroundColor: controller.changeRestaurantBtnColor.value
                  ? MaterialStatePropertyAll(R.colors.hueRose)
                  : MaterialStatePropertyAll(Colors.grey.shade600)),
          child: Center(
              child: Text(R.strings.ksRestaurant, style: R.styles.white14400)));
    }));
  }

  buildHospitalButton() {
    return Expanded(child: Obx(() {
      return ElevatedButton(
          onPressed: () {
            controller.changeHospitalBtnColor.value = true;
            controller.retrieveNearbyRestaurants(
                controller.currentLocation.value,
                R.strings.ksSelectedPlaceHospital);
          },
          style: ButtonStyle(
              backgroundColor: controller.changeHospitalBtnColor.value
                  ? MaterialStatePropertyAll(R.colors.hueViolet)
                  : MaterialStatePropertyAll(Colors.grey.shade600)),
          child: Center(
              child: Text(R.strings.ksHospital, style: R.styles.white14400)));
    }));
  }

  buildBankButton() {
    return Expanded(child: Obx(() {
      return ElevatedButton(
          onPressed: () {
            controller.changeBankBtnColor.value = true;
            controller.retrieveNearbyRestaurants(
                controller.currentLocation.value,
                R.strings.ksSelectedPlaceBank);
          },
          style: ButtonStyle(
              backgroundColor: controller.changeBankBtnColor.value
                  ? MaterialStatePropertyAll(R.colors.hueOrange)
                  : MaterialStatePropertyAll(Colors.grey.shade600)),
          child: Center(
              child: Text(R.strings.ksBank, style: R.styles.white14400)));
    }));
  }

  buildFilterRow() {
    return Positioned(
        top: 10,
        left: 10,
        right: 10,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          buildRestaurantButton(),
          const SizedBox(width: 10),
          buildHospitalButton(),
          const SizedBox(width: 10),
          buildBankButton()
        ]));
  }

  buildInfoWindow() {
    return Obx(() {
      return Visibility(
          visible: controller.isShowInfoWindow.value == true ? true : false,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(children: [
                Container(
                    // height: 115,
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: R.colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: Row(children: [
                      controller.placePhotos.value != ''
                          ? Image.network(
                              '${Config.imgUrl}${controller.placePhotos.value}&key=${Config.kGoogleApiKey}',
                              height: 80,
                              width: 80,
                              fit: BoxFit.fill,
                            )
                          : const SizedBox(),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              controller.placeName.value,
                              style: R.styles.black18600
                                  .merge(const TextStyle(fontSize: 20)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(children: [
                              Text(
                                controller.ratings.value.toString(),
                                style: R.styles.disable14400,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 5),
                              RatingBarIndicator(
                                  rating: controller.ratings.value,
                                  itemBuilder: (context, index) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal)
                            ]),
                            const SizedBox(height: 5),
                            Text(
                                controller.placeOpenNow.value
                                    ? R.strings.ksOpen
                                    : R.strings.ksClose,
                                style: R.styles.disable14400.merge(TextStyle(
                                    color: controller.placeOpenNow.value
                                        ? R.colors.green
                                        : R.colors.kcRed)),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis)
                          ]))
                    ]))
              ])));
    });
  }
}
