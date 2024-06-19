class WeatherResponse {
  final Main main;
  final List<Weather> weather;
  final Wind wind;

  WeatherResponse({required this.main, required this.weather, required this.wind});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      main: Main.fromJson(json['main']),
      weather: List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      wind: Wind.fromJson(json['wind']),
    );
  }
}

class Main {
  final double temp;
  final int humidity;

  Main({required this.temp, required this.humidity});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      humidity: json['humidity'],
    );
  }
}

class Weather {
  final String description;
  final String icon;

  Weather({required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
    );
  }
}
