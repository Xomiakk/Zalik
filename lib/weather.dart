// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));
String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.hourlyUnits,
    required this.hourly,
  });

  double latitude;
  double longitude;
  double generationtimeMs;
  int utcOffsetSeconds;
  String timezone;
  String timezoneAbbreviation;
  int elevation;
  HourlyUnits hourlyUnits;
  Hourly hourly;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    generationtimeMs: json["generationtime_ms"].toDouble(),
    utcOffsetSeconds: json["utc_offset_seconds"],
    timezone: json["timezone"],
    timezoneAbbreviation: json["timezone_abbreviation"],
    elevation: json["elevation"],
    hourlyUnits: HourlyUnits.fromJson(json["hourly_units"]),
    hourly: Hourly.fromJson(json["hourly"]),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "generationtime_ms": generationtimeMs,
    "utc_offset_seconds": utcOffsetSeconds,
    "timezone": timezone,
    "timezone_abbreviation": timezoneAbbreviation,
    "elevation": elevation,
    "hourly_units": hourlyUnits.toJson(),
    "hourly": hourly.toJson(),
  };
}

class Hourly {
  Hourly({
    required this.time,
    required this.temperature2M,
  });

  List<String?> time;
  List<double> temperature2M;

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    time: List<String>.from(json["time"].map((x) => x)),
    temperature2M: List<double>.from(json["temperature_2m"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "time": List<dynamic>.from(time.map((x) => x)),
    "temperature_2m": List<dynamic>.from(temperature2M.map((x) => x)),
  };
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

  Map<String, dynamic> toJson() => {
    "time": time,
    "temperature_2m": temperature2M,
  };
}
