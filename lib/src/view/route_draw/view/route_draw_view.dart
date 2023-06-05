import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/src/view/route_draw/controller/route_draw_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../global/constants/resources/resources.dart';
import '../../../../global/widgets/location_list_style.dart';

class RouteDrawView extends GetView<RouteDrawController> {
  const RouteDrawView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(R.strings.ksRouteDraw)),
        body: Stack(children: [buildMap(), buildLocationTextField(context)]));
  }

  buildMap() {
    return Obx(() =>
        controller.currentLocation.value != const LatLng(0.0, 0.0) ||
                controller.polylineCoordinates.isNotEmpty ||
                controller.markers.isNotEmpty
            ? GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                    target: controller.currentLocation.value, zoom: 14.0),
                myLocationEnabled: true,
                polylines: {
                  Polyline(
                      polylineId: PolylineId(R.strings.ksPolyLineId),
                      points: controller.polylineCoordinates,
                      color: Colors.blue,
                      width: 6)
                },
                markers: controller.markers)
            : const Center(child: CircularProgressIndicator()));
  }

  buildLocationTextField(BuildContext context) {
    return Positioned(
        top: 10,
        left: 10,
        right: 10,
        child: Column(children: [
          buildSearchBox(),
          const SizedBox(height: 10),
          buildSearchListView()
        ]));
  }

  buildSearchListView() {
    return Obx(() {
      return Visibility(
          visible: controller.placePrediction.isNotEmpty ? true : false,
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: R.colors.white,
                  borderRadius: BorderRadius.circular(15)),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.placePrediction.length,
                  itemBuilder: (context, index) => LocationListStyle(
                      location: controller.placePrediction[index].description!,
                      onTap: () async {
                        controller.fiscalAddressSelected(index);
                      }),
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                          height: 1, thickness: 1, color: R.colors.border))));
    });
  }

  buildSearchBox() {
    return Form(
        child: Material(
            elevation: 10.0,
            color: R.colors.white,
            borderRadius: BorderRadius.circular(30),
            child: TextFormField(
                onChanged: (value) {
                  controller.fiscalPlaceAutocomplete(value);
                },
                controller: controller.searchController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: R.strings.ksSearchLocationHint,
                    hintStyle: R.styles.disabledTextStyle,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(15)))));
  }
}
