import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/global/widgets/location_list_style.dart';
import 'package:google_map_modules/src/view/search_location/component/view_address_bottomsheet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../global/constants/resources/resources.dart';
import '../controller/search_location_controller.dart';

class SearchLocationView extends GetView<SearchLocationController> {
  const SearchLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(R.strings.ksSearchLocation)),
        body: Obx(() => controller.markers.isNotEmpty
            ? Stack(children: [
                buildGoogleMap(),
                buildLocationTextField(context),
                buildMapTypeContainer(),
                enterTitleContainer()
              ])
            : const Center(child: CircularProgressIndicator())));
  }

  buildLocationTextField(BuildContext context) {
    return Positioned(
        top: 10,
        left: 10,
        right: 10,
        child: Column(children: [
          buildSearchBox(),
          const SizedBox(height: 10),
          buildSearchList()
        ]));
  }

  buildSearchList() {
    return Obx(() {
      return Visibility(
          visible: controller.placePrediction.isNotEmpty ? true : false,
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: R.colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
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

  buildGoogleMap() {
    return Padding(
        padding: EdgeInsets.only(bottom: Get.height * 0.08),
        child: Obx(() {
          return GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.currentLocation.value,
                zoom: 14.0,
              ),
              mapType: controller.mapType.value,
              markers: controller.markers,
              onCameraMove: (position) {
                controller.markers.clear();
                controller.markers.add(Marker(
                  markerId: controller.markerId,
                  position: position.target,
                ));
                controller.lat = position.target.latitude;
                controller.lng = position.target.longitude;
              },
              onCameraIdle: () async {
                var placeMarks = await placemarkFromCoordinates(
                    controller.lat, controller.lng);

                controller.address.value =
                    '${placeMarks.first.name!.isNotEmpty ? '${placeMarks.first.name}, ' : ''}${placeMarks.first.subLocality!.isNotEmpty ? '${placeMarks.first.subLocality}, ' : ''}${placeMarks.first.locality!.isNotEmpty ? '${placeMarks.first.locality}, ' : ''}${placeMarks.first.subAdministrativeArea!.isNotEmpty ? '${placeMarks.first.subAdministrativeArea}, ' : ''}${placeMarks.first.postalCode!.isNotEmpty ? '${placeMarks.first.postalCode}, ' : ''}${placeMarks.first.administrativeArea!.isNotEmpty ? placeMarks.first.administrativeArea : ''}';

                controller.name.value = placeMarks.first.name!.isNotEmpty
                    ? '${placeMarks.first.name}, '
                    : '';
                controller.subLocality.value =
                    placeMarks.first.subLocality!.isNotEmpty
                        ? '${placeMarks.first.subLocality}, '
                        : '';
                controller.locality.value =
                    placeMarks.first.locality!.isNotEmpty
                        ? '${placeMarks.first.locality}, '
                        : '';
                controller.subAdministrativeArea.value =
                    placeMarks.first.subAdministrativeArea!.isNotEmpty
                        ? '${placeMarks.first.subAdministrativeArea}, '
                        : '';
                controller.postalCode.value =
                    placeMarks.first.postalCode!.isNotEmpty
                        ? '${placeMarks.first.postalCode}, '
                        : '';
                controller.administrativeArea.value =
                    placeMarks.first.administrativeArea!.isNotEmpty
                        ? '${placeMarks.first.administrativeArea}'
                        : '';
                controller.latitude.value = controller.lat.toString();
                controller.longitude.value = controller.lng.toString();
              });
        }));
  }

  enterTitleContainer() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
            onVerticalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dy > sensitivity) {
                // Down Swipe
              } else if (details.delta.dy < -sensitivity) {
                // Up Swipe
                openEnterDetailBottomSheet();
              }
            },
            child: InkWell(
                onTap: () {
                  openEnterDetailBottomSheet();
                },
                child: Container(
                    alignment: Alignment.bottomCenter,
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                        color: R.colors.white,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(R.icons.upArrow, height: 20, width: 16),
                          const SizedBox(height: 5),
                          Text(R.strings.viewAddress, style: R.styles.red18600)
                        ])))));
  }

  openEnterDetailBottomSheet() {
    Get.bottomSheet(
        backgroundColor: Colors.white,
        Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: ViewAddressBottomSheet(
                name: controller.name.value,
                address: controller.address.value,
                latitude: controller.latitude.value,
                longitude: controller.longitude.value,
                administrativeArea: controller.administrativeArea.value,
                locality: controller.locality.value,
                postalCode: controller.postalCode.value,
                subAdministrativeArea: controller.subAdministrativeArea.value,
                subLocality: controller.subLocality.value)));
  }

  buildMapTypeContainer() {
    return Padding(
        padding:
            EdgeInsets.only(bottom: Get.height * 0.11, right: Get.width * 0.17),
        child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
                width: 105,
                height: 30,
                decoration: BoxDecoration(
                    color: R.colors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(color: R.colors.border, blurRadius: 1)
                    ]),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () =>
                              controller.mapType.value = MapType.normal,
                          child:
                              Text(R.strings.map, style: R.styles.black11500)),
                      Container(
                          height: 30, color: R.colors.lightGrey, width: 1),
                      InkWell(
                          onTap: () =>
                              controller.mapType.value = MapType.satellite,
                          child: Text(R.strings.sateLite,
                              style: R.styles.black11500))
                    ]))));
  }
}
