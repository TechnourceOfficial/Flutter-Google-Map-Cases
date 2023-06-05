import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/global/utils/config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../../global/constants/resources/resources.dart';
import '../../../../global/dialogues/dialogue_helper.dart';

class MultipleMarkerController extends GetxController {
  GoogleMapController? mapController;
  Rx<LatLng> currentLocation = const LatLng(0.0, 0.0).obs;
  Set<Marker> markers = <Marker>{}.obs;
  RxString placeName = "".obs, placePhotos = "".obs;
  RxDouble ratings = 0.0.obs;
  RxBool isShowInfoWindow = false.obs,
      placeOpenNow = false.obs,
      changeRestaurantBtnColor = true.obs,
      changeHospitalBtnColor = false.obs,
      changeBankBtnColor = false.obs;
  final places = GoogleMapsPlaces(apiKey: Config.kGoogleApiKey);

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
      retrieveNearbyRestaurants(
          currentLocation.value, R.strings.ksSelectedPlaceRestaurant);
    });
  }

  Future<void> retrieveNearbyRestaurants(
      LatLng userLocation, String type) async {
    PlacesSearchResponse response = await places.searchNearbyWithRadius(
        Location(lat: userLocation.latitude, lng: userLocation.longitude),
        10000,
        type: type);

    List<dynamic> nearByPlaces = response.results;
    for (var i = 0; i < nearByPlaces.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(nearByPlaces[i].name),
          onTap: () {
            placeName.value = "";
            ratings.value = 0.0;
            placeOpenNow.value = false;
            placePhotos.value = "";
            isShowInfoWindow.value = true;
            placeName.value = nearByPlaces[i].name;
            ratings.value = nearByPlaces[i].rating as double;
            placeOpenNow.value = nearByPlaces[i].openingHours!.openNow;
            placePhotos.value = nearByPlaces[i].photos.first.photoReference;
          },
          icon: Config.pinIndex.isEmpty
              ? BitmapDescriptor.defaultMarkerWithHue(
                  type == R.strings.ksSelectedPlaceRestaurant
                      ? BitmapDescriptor.hueRose
                      : type == R.strings.ksSelectedPlaceHospital
                          ? BitmapDescriptor.hueViolet
                          : BitmapDescriptor.hueOrange)
              : await getBitmapDescriptorFromAssetBytes(
                  Config.pinList[int.parse(Config.pinIndex)], 100),
          position: LatLng(nearByPlaces[i].geometry!.location.lat,
              nearByPlaces[i].geometry!.location.lng)));
    }
    Config.pinIndex = "";
    Config.placeType = "";
  }

  // This function is used for display custom marker
  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List? imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData!);
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }
}
