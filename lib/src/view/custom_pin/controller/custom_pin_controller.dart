import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/global/utils/config.dart';

import '../../../../global/constants/resources/resources.dart';

class CustomPinController extends GetxController {
  RxInt tapImage = 0.obs;
  RxString selectType = "".obs;

  List customPinList = [
    Image.asset(R.icons.orangePin),
    Image.asset(R.icons.redPin),
    Image.asset(R.icons.yellowPin),
    Image.asset(R.icons.bluePin),
  ];

  Future<void> showAlertDialog(
      BuildContext context, int selectedPinIndex) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              content: Obx(() {
                return Wrap(children: [
                  Column(children: [
                    ListTile(
                        title: Text(R.strings.ksRestaurant),
                        leading: Radio(
                            value: R.strings.ksSelectedPlaceRestaurant,
                            groupValue: selectType.value,
                            onChanged: (value) {
                              selectType.value = value!;
                            })),
                    ListTile(
                        title: Text(R.strings.ksHospital),
                        leading: Radio(
                            value: R.strings.ksSelectedPlaceHospital,
                            groupValue: selectType.value,
                            onChanged: (value) {
                              selectType.value = value!;
                            })),
                    ListTile(
                        title: Text(R.strings.ksBank),
                        leading: Radio(
                            value: R.strings.ksSelectedPlaceBank,
                            groupValue: selectType.value,
                            onChanged: (value) {
                              selectType.value = value!;
                            }))
                  ])
                ]);
              }),
              actions: [
                TextButton(
                    child: Text(R.strings.ksCancel),
                    onPressed: () {
                      Get.back();
                    }),
                TextButton(
                    child: Text(R.strings.ksOk),
                    onPressed: () {
                      Config.pinIndex = selectedPinIndex.toString();
                      Config.placeType = selectType.value;
                      Get.back();
                      Get.back();
                    })
              ]);
        });
  }
}
