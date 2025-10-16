import '../services/location.dart';
import '../services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
var apiKey = dotenv.env["api_key"];
class WeatherModel {
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

  Future<dynamic> getLocation() async {
    try {
      Location location = Location();
      await location.getLocation();
      final url =
          '$baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

      Network network = Network(url:url);
      var data = await network.getData();
      return data;

    } catch (e) {
      print('Error retrieving location: $e');
      return null;
    }
  }
}
