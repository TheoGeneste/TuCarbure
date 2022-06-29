import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tu_carbure/view/viewmodels/stations_viewmodel.dart';

class MyMap extends StatefulWidget {
  final int rangeValue;
  MyMap({Key? key, required this.rangeValue}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late Position _currentPosition;
  late LocationSettings locationSettings;


  @override
  Widget build(BuildContext context) {
    setLocation();
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
      }
    );
    List<Marker> _markers = [];
    _determinePosition();
    _getCurrentLocation();
     StationViewModel stationViewModel = context.read<StationViewModel>();
    _markers.add(Marker(
      point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      width: 80,
      height: 80,
      builder: (context) => Icon(Icons.location_on, color: Colors.red,),
    ));
    return FutureBuilder(
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          final data = snapshot.data as List;
          data.forEach((element) {
            _markers.add(Marker(
              point: LatLng(element['adresse']['latitude'], element['adresse']['longitude']),
              width: 80,
              height: 80,
              builder: (context) {
                return IconButton(
                  onPressed: () {
                      print(element);
                  },
                  icon: Icon(Icons.local_gas_station, color: Colors.green,),
                );
              }
            ));
          });
          return Center(
            child: Container(
              child: Column(
                children: [
                  Flexible(
                      child: FlutterMap(
                        options: MapOptions(
                          plugins: [
                            LocationMarkerPlugin(),
                          ],
                          maxZoom: 18.4,
                          center: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayerOptions(
                              markers: _markers as List<Marker>
                          ),
                          LocationMarkerLayerOptions(),
                        ],

                      )
                  ),
                  SlidingUpPanel(
                      panel: Center(child: Text("This is the sliding Widget"),),
                  )
                ],
              ),
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
      future: stationViewModel.getStationInPerimetre(_currentPosition.longitude, _currentPosition.latitude, widget.rangeValue),
    );
  }

  void setLocation(){
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
            "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          )
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    print(permission);
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  _getCurrentLocation() async {
    await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState((){
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
