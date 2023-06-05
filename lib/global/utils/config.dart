
import '../constants/resources/resources.dart';

class Config {
  static var appName = "Google Map Module";
  static var kGoogleApiKey = 'PUT_YOUR_API_KEY_HERE';

  static var pinIndex = "";
  static var placeType = "";

  static List pinList = [
    R.icons.orangePin,
    R.icons.redPin,
    R.icons.yellowPin,
    R.icons.bluePin
  ];

  ///Google places
  static const googleMapBaseUrl = 'https://maps.googleapis.com/maps/';
  static const getPlaces = 'api/place/autocomplete/json';
  static const getPlacesDetails = 'api/place/details/json';
  static const imgUrl = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=';
}
