import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/resources/resources.dart';
import '../utils/config.dart';

// ignore: must_be_immutable
class AppDialogue extends StatelessWidget {
  VoidCallback? onPositiveClick;
  VoidCallback? onNegativeClick;
  String? positiveBtnText;
  String? dialogueMsg;
  String? title;

  AppDialogue(
      {Key? key,
      this.onNegativeClick,
      required this.onPositiveClick,
      required this.dialogueMsg,
      this.title,
      required this.positiveBtnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(30),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(children: [
                        const SizedBox(height: 10),
                        Row(children: [
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(title ?? Config.appName,
                                  textAlign: TextAlign.center,
                                  style: R.styles.red24500))
                        ]),
                        const SizedBox(height: 30),
                        Text(
                          dialogueMsg!,
                          style: R.styles.primary16500
                              .merge(TextStyle(color: R.colors.appTextDisable)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        buildPositiveButton()
                      ])))
            ]));
  }

  buildPositiveButton() {
    return Row(children: [
      Expanded(
          child: TextButton(
              onPressed: onPositiveClick,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          vertical: 15, horizontal: Get.width * 0.1)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(R.colors.kcRed),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: R.colors.kcRed)))),
              child: Text(positiveBtnText!.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))))
    ]);
  }
}
