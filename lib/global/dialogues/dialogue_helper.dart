import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/global/dialogues/loader.dart';

import 'app_dialogue.dart';

class DialogueHelper {
  static showProgress({String? msg}) {
    Get.dialog(ProgressLoader(
      msg: msg ?? "",
    ));
  }

  static hideProgress() {
    if (Get.isDialogOpen!) {
      Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
    }
  }

  static showAppDialogue(
      {required VoidCallback onPositiveClick,
      VoidCallback? onNegativeClick,
      required String positiveBtnText,
      required String cancelBtnText,
      bool isFromDashboard = false,
      bool? cancelable,
      bool? hideCancelBtn,
      bool? closeButton,
      required bool isShowCancelButton,
      bool? isHtmlText,
      String? title,
      required String dialogueMsg}) {
    showDialog(
        context: Get.context!,
        builder: (ctx) {
          return WillPopScope(
              onWillPop: () async => cancelable ?? true,
              child: AppDialogue(
                  title: title,
                  dialogueMsg: dialogueMsg,
                  onNegativeClick: onNegativeClick,
                  onPositiveClick: onPositiveClick,
                  positiveBtnText: positiveBtnText));
        });
  }
}
