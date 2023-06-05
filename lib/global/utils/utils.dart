import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../constants/resources/resources.dart';
import '../dialogues/dialogue_helper.dart';
import '../enum/state_status.dart';

class Utils {
  static PermissionStateStatus? permissionStatus;

  static Future<bool> haveLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      DialogueHelper.showAppDialogue(
          onPositiveClick: () {
            Geolocator.openLocationSettings();
            Get.back();
          },
          cancelable: true,
          hideCancelBtn: true,
          onNegativeClick: () {
            Get.back();
          },
          positiveBtnText: R.strings.ksGiveAccess,
          cancelBtnText: R.strings.ksCancel,
          dialogueMsg: R.strings.ksLocationServiceDisableMsg,
          isShowCancelButton: false);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        DialogueHelper.showAppDialogue(
            onPositiveClick: () async {
              Get.back();
              await Geolocator.requestPermission();
            },
            cancelable: true,
            hideCancelBtn: true,
            onNegativeClick: () {
              Get.back();
            },
            positiveBtnText: R.strings.ksGiveAccess,
            cancelBtnText: R.strings.ksCancel,
            dialogueMsg: R.strings.ksLocationPermissionDisableMsg,
            isShowCancelButton: false);
        if (permission == LocationPermission.denied) {
          permissionStatus = PermissionStateStatus.denied;
          return false;
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      DialogueHelper.showAppDialogue(
          onPositiveClick: () {
            Geolocator.openLocationSettings();
            Get.back();
          },
          cancelable: true,
          hideCancelBtn: true,
          onNegativeClick: () {
            Get.back();
          },
          positiveBtnText: R.strings.ksGiveAccess,
          cancelBtnText: R.strings.ksCancel,
          dialogueMsg: R.strings.ksLocationPermissionDisableMsg,
          isShowCancelButton: false);
      return false;
    }
    permissionStatus = PermissionStateStatus.granted;
    return true;
  }
}
