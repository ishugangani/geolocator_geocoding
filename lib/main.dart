import 'package:flutter/material.dart';
import 'package:geolocator_geocoding/screen/home/view/home_screen.dart';
import 'package:geolocator_geocoding/screen/map/view/map_screen.dart';
import 'package:get/get.dart';
void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(p0) => HomeScreen(),
        'map':(p0) => MapScreen(),
      },
    ),
  );
}