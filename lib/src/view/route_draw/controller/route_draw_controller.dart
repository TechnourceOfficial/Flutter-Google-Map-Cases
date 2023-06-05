import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/global/utils/config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../global/constants/resources/resources.dart';
import '../../../../global/dialogues/dialogue_helper.dart';
import '../../../../global/google_map/auto_complete_predictions.dart';
import '../../../../global/google_map/google_map_repo.dart';

class RouteDrawController extends GetxController {
  Rx<LatLng> currentLocation = const LatLng(0.0, 0.0).obs;
  Rx<LatLng> sourceLocation = const LatLng(0.0, 0.0).obs;
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  GoogleMapController? mapController;
  final TextEditingController searchController = TextEditingController();
  Set<Marker> markers = <Marker>{}.obs;
  RxList<Predictions> placePrediction = <Predictions>[].obs;
  RxString placeId = "".obs;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void onInit() {
    super.onInit();
    getUserCurrentLocation();
  }

  Future<Position> currentLocationPermission() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  getUserCurrentLocation() {
    currentLocationPermission().then((value) async {
      currentLocation.value = LatLng(value.latitude, value.longitude);
      sourceLocation.value = LatLng(value.latitude, value.longitude);
      markers.add(Marker(
          markerId: MarkerId(R.strings.ksSource),
          position: LatLng(value.latitude, value.longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          flat: true,
          infoWindow: InfoWindow(title: R.strings.ksCurrentLocation)));
    });
  }

  fiscalPlaceAutocomplete(String query) async {
    if (Config.kGoogleApiKey.contains(R.strings.putYourAPIKeyHere)) {
      showErrorDialog();
    } else {
      var mapPlacesResponse = await GoogleMapRepo.getPlaces(query);
      placePrediction.value = mapPlacesResponse.predictions!;
    }
  }

  fiscalAddressSelected(index) async {
    Get.focusScope?.unfocus();
    placeId.value = placePrediction[index].placeId!;
    var googleMapsDetailResponse =
        await GoogleMapRepo.getPlaceDetail(placeId.value);
    if (googleMapsDetailResponse.status == 'OK') {
      searchController.clear();
      markers.add(Marker(
          markerId: MarkerId(R.strings.ksDestinationMarkerId),
          anchor: const Offset(0.5, 0.5),
          position: LatLng(
              googleMapsDetailResponse.result!.geometry!.location!.lat!,
              googleMapsDetailResponse.result!.geometry!.location!.lng!),
          flat: true,
          zIndex: 2,
          infoWindow: InfoWindow(title: googleMapsDetailResponse.result!.name),
          icon: BitmapDescriptor.defaultMarker));

      // animate camera to selected place
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(googleMapsDetailResponse.result!.geometry!.location!.lat!,
              googleMapsDetailResponse.result!.geometry!.location!.lng!),
          12.5));
    }
    getPolyPoints(
        destinationLatitude:
            googleMapsDetailResponse.result!.geometry!.location!.lat!,
        destinationLongitude:
            googleMapsDetailResponse.result!.geometry!.location!.lng!);
    placePrediction.value = [];
  }

  void getPolyPoints(
      {required double destinationLatitude,
      required double destinationLongitude}) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
            Config.kGoogleApiKey,
            PointLatLng(
                sourceLocation.value.latitude, sourceLocation.value.longitude),
            PointLatLng(destinationLatitude, destinationLongitude));

    if (polylineResult.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in polylineResult.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
  }

  showErrorDialog() {
    DialogueHelper.showAppDialogue(
        onPositiveClick: () {
          Get.back();
        },
        hideCancelBtn: true,
        onNegativeClick: () {
          Get.back();
        },
        positiveBtnText: R.strings.ksOk,
        cancelBtnText: R.strings.ksCancel,
        dialogueMsg: R.strings.putYourAPIKeyMsg,
        isShowCancelButton: false);
  }
}
