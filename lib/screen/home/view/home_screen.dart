import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_geocoding/screen/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController HC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Live Location",style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  var status = await Permission.location.status;
                  if (status.isDenied) {
                    await Permission.location.request();
                  }
                },
                child: Text(
                  "Permission",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);

                  HC.lat.value = position.latitude;
                  HC.lon.value = position.longitude;
                },
                child: Text(
                  "Location",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Latitude: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("${HC.lat}",style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Longitude: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("${HC.lon}",style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      List<Placemark> list = await placemarkFromCoordinates(HC.lat.value, HC.lon.value);

                      print("${HC.lat.value}:${HC.lon.value}");
                      HC.placeList.value = list;
                    },
                    child: Text(
                      "Address",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Get.toNamed('map');
                    },
                    child: Text(
                      "On Map",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Obx(
                () => Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1.5,color: Colors.black),
                  ),
                  child: Center(
                    child: Text(HC.placeList.isEmpty ? " " : "${HC.placeList[0]}",style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
