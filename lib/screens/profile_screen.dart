import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';

class ProfileScreen extends StatelessWidget {
  final Location location = Location();
  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            LocationData? currentLocation;
            try {
              currentLocation = await location.getLocation();
            } catch (e) {
              print('Failed to get location: $e');
            }

            if (currentLocation != null) {
              try {
                var response = await dio.get(
                  'https://api.openweathermap.org/data/2.5/weather',
                  queryParameters: {
                    'lat': currentLocation.latitude,
                    'lon': currentLocation.longitude,
                    'appid': '36bc469f90b0516e86841739d251e22b',
                    'units': 'metric',
                  },
                );

                var weather = response.data;
                String weatherDescription = weather['weather'][0]['description'];
                double temp = weather['main']['temp'];
                double windSpeed = weather['wind']['speed'];

                // Show weather information
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Weather Information'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Description: $weatherDescription'),
                        Text('Temperature: $temp°C'),
                        Text('Wind Speed: $windSpeed m/s'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              } catch (e) {
                print('Failed to fetch weather data: $e');
                // Handle error
              }
            }
          },
          child: Text('Get My Location Weather'),
        ),
      ),
    );
  }
}
