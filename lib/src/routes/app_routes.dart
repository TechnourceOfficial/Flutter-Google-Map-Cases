part of 'app_pages.dart';
abstract class Routes {
  Routes._();

  static const homeView = _Paths.homeView;
  static const searchLocationView = _Paths.searchLocationView;
  static const multipleMarkerView = _Paths.multipleMarkerView;
  static const routeDrawView = _Paths.routeDrawView;
  static const clusterView = _Paths.clusterView;
  static const customPinView = _Paths.customPinView;
}

abstract class _Paths {
  _Paths._();

  static const homeView = '/homeView';
  static const searchLocationView = '/searchLocationView';
  static const multipleMarkerView = '/multipleMarkerView';
  static const routeDrawView = '/routeDrawView';
  static const clusterView = '/clusterView';
  static const customPinView = '/customPinView';
}
