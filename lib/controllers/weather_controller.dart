import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app_task/services/weather_services.dart';
import '../models/weather_response_model.dart';


class WeatherController extends GetxController {
  var isLoading = true.obs;
  var weatherResponse = WeatherResponse(
    main: Main(temp: 0, humidity: 0),
    weather: [Weather(description: '', icon: '')],
    wind: Wind(speed: 0),
  ).obs;

  final WeatherService weatherService;
  final GetStorage box = GetStorage();

  WeatherController(this.weatherService);

  void fetchWeatherByCity(String city) async {
    try {
      isLoading(true);
      var cacheKey = 'city-$city';
      if (box.hasData(cacheKey)) {
        weatherResponse(WeatherResponse.fromJson(box.read(cacheKey)));
      } else {
        var result = await weatherService.getWeatherByCity(city);
        weatherResponse(WeatherResponse.fromJson(result));
        box.write(cacheKey, result);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch weather data");
    } finally {
      isLoading(false);
    }
  }

  void fetchWeatherByZip(String zip) async {
    try {
      isLoading(true);
      var cacheKey = 'zip-$zip';
      if (box.hasData(cacheKey)) {
        weatherResponse(WeatherResponse.fromJson(box.read(cacheKey)));
      } else {
        var result = await weatherService.getWeatherByZip(zip);
        weatherResponse(WeatherResponse.fromJson(result));
        box.write(cacheKey, result);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch weather data");
    } finally {
      isLoading(false);
    }
  }
}
