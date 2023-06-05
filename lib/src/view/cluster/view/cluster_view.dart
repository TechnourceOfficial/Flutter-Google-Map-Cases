import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_modules/src/view/cluster/controller/cluster_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../global/constants/resources/resources.dart';

class ClusterView extends GetView<ClusterController> {
  const ClusterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(R.strings.ksCluster)),
      body: Obx(() => GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: controller.cameraPosition,
          markers: controller.markers,
          onMapCreated: (GoogleMapController googleMapController) {
            controller.mapController.complete(googleMapController);
            controller.manager?.setMapId(googleMapController.mapId);
          },
          onCameraMove: controller.manager?.onCameraMove,
          onCameraIdle: controller.manager?.updateMap))
    );
  }
}
