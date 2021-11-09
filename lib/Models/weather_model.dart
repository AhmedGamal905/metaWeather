import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

class Weather {
  Weather({
    required this.longitude,
    required this.hourlyUnits,
    required this.currentWeather,
    required this.elevation,
    required this.utcOffsetSeconds,
    required this.generationtimeMs,
    required this.hourly,
    required this.latitude,
  });

  double longitude;
  HourlyUnits hourlyUnits;
  CurrentWeather currentWeather;
  double elevation;
  int utcOffsetSeconds;
  double generationtimeMs;
  Hourly hourly;
  double latitude;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        longitude: json["longitude"].toDouble(),
        hourlyUnits: HourlyUnits.fromJson(json["hourly_units"]),
        currentWeather: CurrentWeather.fromJson(json["current_weather"]),
        elevation: json["elevation"].toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        generationtimeMs: json["generationtime_ms"].toDouble(),
        hourly: Hourly.fromJson(json["hourly"]),
        latitude: json["latitude"].toDouble(),
      );
}

class CurrentWeather {
  CurrentWeather({
    required this.weathercode,
    required this.time,
    required this.winddirection,
    required this.windspeed,
    required this.temperature,
  });

  int weathercode;
  String time;
  int winddirection;
  double windspeed;
  double temperature;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        weathercode: json["weathercode"],
        time: json["time"],
        winddirection: json["winddirection"],
        windspeed: json["windspeed"].toDouble(),
        temperature: json["temperature"].toDouble(),
      );
}

class Hourly {
  Hourly({
    required this.time,
    required this.temperature2M,
  });

  List<String> time;
  List<double> temperature2M;

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        time: List<String>.from(json["time"].map((x) => x)),
        temperature2M:
            List<double>.from(json["temperature_2m"].map((x) => x.toDouble())),
      );
}

class HourlyUnits {
  HourlyUnits({
    required this.time,
    required this.temperature2M,
  });

  String time;
  String temperature2M;

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
        time: json["time"],
        temperature2M: json["temperature_2m"],
      );
}
