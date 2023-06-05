import 'package:get/get.dart';
import 'package:google_map_modules/src/view/cluster/binding/cluster_binding.dart';
import 'package:google_map_modules/src/view/cluster/view/cluster_view.dart';
import 'package:google_map_modules/src/view/custom_pin/binding/custom_pin_binding.dart';
import 'package:google_map_modules/src/view/custom_pin/view/custom_pin_view.dart';
import 'package:google_map_modules/src/view/home/binding/home_binding.dart';
import 'package:google_map_modules/src/view/home/view/home_view.dart';
import 'package:google_map_modules/src/view/multiple_markers/binding/multiple_marker_binding.dart';
import 'package:google_map_modules/src/view/multiple_markers/view/multiple_marker_view.dart';
import 'package:google_map_modules/src/view/route_draw/binding/route_draw_binding.dart';
import 'package:google_map_modules/src/view/route_draw/view/route_draw_view.dart';
import 'package:google_map_modules/src/view/search_location/view/search_location_view.dart';

import '../view/search_location/binding/search_location_binding.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.homeView;

  static final routes = [
    GetPage(
      name: _Paths.homeView,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.searchLocationView,
      page: () => const SearchLocationView(),
      binding: SearchLocationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.multipleMarkerView,
      page: () => const MultipleMarkerView(),
      binding: MultipleMarkerBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.routeDrawView,
      page: () => const RouteDrawView(),
      binding: RouteDrawBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.clusterView,
      page: () => const ClusterView(),
      binding: ClusterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.customPinView,
      page: () => const CustomPinView(),
      binding: CustomPinBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
