import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metaweather/Models/weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather();
}

class FetchWeatherApi implements WeatherRepository {
  @override
  Future<Weather> getWeather() async {
    Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    String _baseUrl =
        "https://api.open-meteo.com/v1/forecast?latitude=${location.latitude.toString()}&longitude=${location.longitude.toString()}&hourly=temperature_2m&current_weather=true&timezone=Africa%2FCairo";

    final response = await Dio().get(_baseUrl);
    if (response.statusCode == 200) {
      Weather weather = Weather.fromJson(response.data);
      return weather;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
