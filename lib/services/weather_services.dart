import 'package:dio/dio.dart';

class WeatherService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://api.openweathermap.org/data/2.5/"));
  String apiKey = "36bc469f90b0516e86841739d251e22b";


  Future<Map<String, dynamic>> getWeatherByCity(String city) async {
    final response = await _dio.get("/weather", queryParameters: {
      "q": city,
      "appid": apiKey,
      "units": "metric"
    });
    return response.data;
  }

  Future<Map<String, dynamic>> getWeatherByZip(String zip) async {
    final response = await _dio.get("/weather", queryParameters: {
      "zip": zip,
      "appid": apiKey,
      "units": "metric"
    });
    return response.data;
  }
}
