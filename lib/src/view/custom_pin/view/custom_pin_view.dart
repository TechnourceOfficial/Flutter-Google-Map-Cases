import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/src/view/custom_pin/controller/custom_pin_controller.dart';

import '../../../../global/constants/resources/resources.dart';

class CustomPinView extends GetView<CustomPinController> {
  const CustomPinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(R.strings.ksCustomPins)),
        body: Column(children: [
          Expanded(
              child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5.0,
                  children:
                      List.generate(controller.customPinList.length, (index) {
                    return Center(child: InkWell(
                          onTap: () => controller.showAlertDialog(context,index),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: R.colors.black)),
                              padding: const EdgeInsets.all(10),
                              width: 90,
                              height: 90,
                              child: controller.customPinList[index]))
                    );
                  })))
        ]));
  }
}
