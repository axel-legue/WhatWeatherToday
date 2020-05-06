import 'package:clima/services/location.dart';
import 'package:clima/services/network_helper.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  NetworkHelper networkHelper;
  var weatherData;

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    // Get Device Location
    await location.getCurrentLocation();

    networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kOpenWeatherKey&units=metric');
    weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String city) async {
    networkHelper = NetworkHelper(
        '$openWeatherMapUrl?q=$city&appid=$kOpenWeatherKey&units=metric');

    weatherData = await networkHelper.getData();
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
