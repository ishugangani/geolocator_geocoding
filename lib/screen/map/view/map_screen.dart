import 'package:flutter/material.dart';
import 'package:geolocator_geocoding/screen/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  HomeController HC = HomeController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          markers: {
            Marker(
              draggable: true,
              markerId: MarkerId("Ishu"),
              position: LatLng(HC.lat.value, HC.lon.value),
            ),
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(HC.lat.value, HC.lon.value),
            zoom: 10,
          ),
        ),
      ),
    );
  }
}
