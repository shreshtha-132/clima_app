import 'package:clima_app/screens/location_screen.dart';
import 'package:clima_app/services/networking.dart';
import 'package:geolocator/geolocator.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle the scenario if the user denies location permission.
        return;
      }
    }

    // get current location

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position.longitude);
    print(position.latitude);

    // make api call

    final apiKey = 'bf37ed037ee6f380172b8531dab4154f';
    final baseUrl = 'http://api.weatherstack.com/current';
    final query = '${position.latitude},${position.longitude}';

    final url = Uri.parse('$baseUrl?access_key=$apiKey&query=$query');

    NetworkHelper nt = NetworkHelper(url: url);

    var weatherData = await nt.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
