import 'package:get/get.dart';
import 'package:google_map_modules/src/view/cluster/controller/cluster_controller.dart';

class ClusterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClusterController>(() => ClusterController());
  }
}
