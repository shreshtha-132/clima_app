import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({required this.url});
  final Uri url;
  late final Map<String, dynamic> weatherData;
  late final response;

  Future getData() async {
    response = await http.get(url);

    if (response.statusCode == 200) {
      // final data = response.body;

      weatherData = json.decode(response.body);
      return weatherData;

      // final data = response.body;

      // Process the 'data' here (e.g., parse JSON or perform other operations).
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
