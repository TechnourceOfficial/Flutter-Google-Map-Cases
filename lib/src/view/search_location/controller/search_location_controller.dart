import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../global/constants/resources/resources.dart';
import '../../../../global/dialogues/dialogue_helper.dart';
import '../../../../global/google_map/auto_complete_predictions.dart';
import '../../../../global/google_map/google_map_repo.dart';
import '../../../../global/utils/config.dart';

class SearchLocationController extends GetxController {
  GoogleMapController? mapController;
  RxString placeId = "".obs,
      name = "".obs,
      latitude = "".obs,
      longitude = "".obs,
      address = "".obs,
      subLocality = "".obs,
      locality = "".obs,
      subAdministrativeArea = "".obs,
      postalCode = "".obs,
      administrativeArea = "".obs;
  double lat = 0.0, lng = 0.0;
  var mapType = MapType.normal.obs;
  Rx<LatLng> currentLocation = const LatLng(0.0, 0.0).obs;
  Set<Marker> markers = <Marker>{}.obs;
  MarkerId markerId = const MarkerId("0");
  final TextEditingController searchController = TextEditingController();
  RxList<Predictions> placePrediction = <Predictions>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserCurrentLocation();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
      markers.clear(); // Clear old markers
      markers.add(Marker(
          markerId: MarkerId(markerId.toString()),
          position: LatLng(
              googleMapsDetailResponse.result!.geometry!.location!.lat!,
              googleMapsDetailResponse.result!.geometry!.location!.lng!),
          icon: BitmapDescriptor.defaultMarker,
          flat: true));

      // animate camera to selected place
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(googleMapsDetailResponse.result!.geometry!.location!.lat!,
              googleMapsDetailResponse.result!.geometry!.location!.lng!),
          15));
      name.value = googleMapsDetailResponse.result!.name.toString();
      address.value =
          googleMapsDetailResponse.result!.formattedAddress.toString();
      subLocality.value =
          googleMapsDetailResponse.result!.formattedAddress.toString();
      latitude.value =
          googleMapsDetailResponse.result!.geometry!.location!.lat.toString();
      longitude.value =
          googleMapsDetailResponse.result!.geometry!.location!.lng.toString();
      final addressComponent =
          googleMapsDetailResponse.result!.addressComponents;
      addressComponent?.forEach((c) {
        final List<String>? type = c.types;
        if (type!.contains('route')) {
          subLocality.value = ' ${subLocality.value} ${c.longName}';
        }
        if (type.contains('locality')) {
          locality.value = c.longName.toString();
        }
        if (type.contains('postal_code')) {
          postalCode.value = c.longName.toString();
        }
        if (type.contains('administrative_area_level_1')) {
          administrativeArea.value = c.longName.toString();
        }
      });
    }
    placePrediction.value = [];
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
      latitude.value = value.latitude.toString();
      latitude.value = value.longitude.toString();
      markers.add(Marker(
          markerId: MarkerId(markerId.toString()),
          position: LatLng(value.latitude, value.longitude),
          icon: BitmapDescriptor.defaultMarker,
          flat: true,
          infoWindow: InfoWindow(title: R.strings.ksCurrentLocation)));

      // show user's current address
      fetchLocation();
    });
  }

  fetchLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
    address.value =
        '${placeMarks.first.name!.isNotEmpty ? '${placeMarks.first.name}, ' : ''}${placeMarks.first.subLocality!.isNotEmpty ? '${placeMarks.first.subLocality}, ' : ''}${placeMarks.first.locality!.isNotEmpty ? '${placeMarks.first.locality}, ' : ''}${placeMarks.first.subAdministrativeArea!.isNotEmpty ? '${placeMarks.first.subAdministrativeArea}, ' : ''}${placeMarks.first.postalCode!.isNotEmpty ? '${placeMarks.first.postalCode}, ' : ''}${placeMarks.first.administrativeArea!.isNotEmpty ? placeMarks.first.administrativeArea : ''}';
    name.value =
        placeMarks.first.name!.isNotEmpty ? '${placeMarks.first.name}, ' : '';
    subLocality.value = placeMarks.first.subLocality!.isNotEmpty
        ? '${placeMarks.first.subLocality}, '
        : '';
    locality.value = placeMarks.first.locality!.isNotEmpty
        ? '${placeMarks.first.locality}, '
        : '';
    subAdministrativeArea.value =
        placeMarks.first.subAdministrativeArea!.isNotEmpty
            ? '${placeMarks.first.subAdministrativeArea}, '
            : '';
    postalCode.value = placeMarks.first.postalCode!.isNotEmpty
        ? '${placeMarks.first.postalCode}, '
        : '';
    administrativeArea.value = placeMarks.first.administrativeArea!.isNotEmpty
        ? '${placeMarks.first.administrativeArea}'
        : '';
  }

  // Using this function we can use icon or image as marker
  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List? imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData!);
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
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
