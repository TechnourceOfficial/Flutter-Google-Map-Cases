
# Google Map Module

Softwares and Version Install Flutter (3.10.1) :

https://docs.flutter.dev/get-started/install    
Install Android Studio : Android Studio Dolphin | 2021.3.1 Patch 1

https://developer.android.com/studio/install    
Xcode (14.2) Install :

https://apps.apple.com/us/app/xcode/id497799835?mt=12

# Features :

- Select and search location with marker at location
- Drag marker to get address of that location
- Multiple and custom markers at map
- Route draw between two points
- Cluster on google map

# Clone Project :

git clone https://github.com/TechnourceDeveloper/Flutter-Google-Map-Cases.git

Steps after project clone successfully.
1. Enable dart support to the current project.
2. If configuration not set then in android studio go to add configuration and add path of main.dart
3. Go to pubspec.yaml file or into terminal of project path run command: flutter pub get
4. After these steps run project.

# About Project files:

State Management Pattern used Getx Pattern (get: ^4.6.5)

https://pub.dev/packages/get    
All global and constants are declared in global folder

**PUT YOUR GOOGLE PLACES API KEY HERE TO MAKE IT WORK**
**path: lib/global/utils/config.dart**
**kGoogleApiKey** is defined in config file.

class Config {  
static var appName = "Google Map Module";  
***static var kGoogleApiKey = 'PUT_YOUR_API_KEY_HERE';***

lib/global/utils/config.dart

# This app contains 4 buttons.

# 1. Search Location
- Search location Google Map will load, and the user's current location and address will be displayed in Google Map.
- Users can also drag marker to get a particular place's address.
- Users can search for any place by using the autocomplete search box, and a marker will move to that location.

**Used Plugins:**

- To load Google Map we use this package:  
  google_maps_flutter - https://pub.dev/packages/google_maps_flutter
- To get the current location and address, we use this packages:
1. geolocator - https://pub.dev/packages/geolocator
2. geocoding - https://pub.dev/packages/geocoding
- To get autocomplete place search box we use Google Places API.

**Screenshots:**

# 2. Multiple Custom Marker
- On click of multiple marker users will find places like restaurants, hospitals, banks, etc. marked.
- Users can also select a custom marker and replace it with the default marker.

**Used Plugins:**

- To get Near by places, we use this package:  
  google_maps_webservice - https://pub.dev/packages/google_maps_webservice

**Screenshots:**


# 3. Route Draw
- On click of route draw Users current location will be display in google map.
- A user can search for his destination and see the route from his sources to the destination.

**Used Plugins:**

- To show route we use this package:  
  flutter_polyline_points  - https://pub.dev/packages/flutter_polyline_points

**Screenshots:**


# 4. Cluster
- On click of cluster **The number on a cluster indicates how many markers it contains**. As you zoom into any of the cluster locations, the number on the cluster decreases, and you begin to see the individual markers on the map. Zooming out of the map consolidates the markers into clusters again.

**Used Plugins:**
- For cluster, we use this package:  
  google_maps_cluster_manager -  https://pub.dev/packages/google_maps_cluster_manager

**Screenshots:**



## License

[MIT](LICENSE)