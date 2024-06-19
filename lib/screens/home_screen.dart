import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_task/controllers/weather_controller.dart';
import 'package:weather_app_task/services/weather_services.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController(WeatherService()));

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Enter city name or zip code",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String query = searchController.text.trim();
                    if (query.isNotEmpty) {
                      if (RegExp(r'^\d+$').hasMatch(query)) {
                        weatherController.fetchWeatherByZip(query);
                      } else {
                        weatherController.fetchWeatherByCity(query);
                      }
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (weatherController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Temperature: ${weatherController.weatherResponse.value.main.temp}°C",
                          style: TextStyle(fontSize: 20),
                        ),
                        Image.network(
                          'http://openweathermap.org/img/wn/${weatherController.weatherResponse.value.weather[0].icon}@2x.png',
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    Text(
                      "Humidity: ${weatherController.weatherResponse.value.main.humidity}%",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Wind Speed: ${weatherController.weatherResponse.value.wind.speed} m/s",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Condition: ${weatherController.weatherResponse.value.weather[0].description}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
