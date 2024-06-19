import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_task/controllers/bottom_nav_bar.dart';
import 'package:weather_app_task/screens/home_screen.dart';
import 'package:weather_app_task/screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final List<Widget> _screens = [
    WeatherScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottom_controller = Get.put<BottomNavController>(BottomNavController());
    return Scaffold(
      body: Obx(() => _screens[bottom_controller.currentIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottom_controller.currentIndex.value,
        onTap: (index) => Get.find<BottomNavController>().changeTabIndex(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}