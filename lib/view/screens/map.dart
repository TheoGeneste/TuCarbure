import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late Position _currentPosition;
  Future<Position> position = Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    _determinePosition();
    return Center(
      child: Container(
        child: Column(
          children: [
            Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(50.357113, 3.518332),
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          point: LatLng(50.357113, 3.518332),
                          width: 80,
                          height: 80,
                          builder: (context) => Icon(Icons.location_on, color: Colors.red,),
                        ),
                        Marker(
                          point: LatLng(48.357113, 3.518332),
                          width: 80,
                          height: 80,
                          builder: (context) => Icon(
                            Icons.local_gas_station, color: Colors.green,
                          ),
                        ),

                      ],
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      print(_currentPosition);
    }).catchError((e) {
      print(e);
    });
  }
}
