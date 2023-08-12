import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude, longitude;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator
        .checkPermission(); // use await here, when geolocator returns the location then only it returns it.
    if (permission == LocationPermission.denied) {
      // Request location permission from the user
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // The user denied the permission. Handle this scenario appropriately.
        // You can show a dialog and explain why the permission is needed,
        // or direct the user to the app settings to manually grant the permission.
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // The user denied the permission forever. Handle this scenario appropriately.
      // You can show a dialog and explain why the permission is needed,
      // or direct the user to the app settings to manually grant the permission.
      return;
    }

    // Permission has been granted, proceed with accessing the location.
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    // Use the obtained position as needed.
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
