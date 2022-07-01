import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tu_carbure/data/favoris_data.dart';
import 'package:tu_carbure/view/viewmodels/stations_viewmodel.dart';
import 'package:tu_carbure/view/widgets/panel_map.dart';

import '../../SharedPrefUtils.dart';

class MyMap extends StatefulWidget {
  final int rangeValue;
  final Map<String, bool> tableauCarburant;
  MyMap({Key? key, required this.rangeValue, required this.tableauCarburant}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late LocationSettings locationSettings;
  var _stationSelectionne = {};
  late Position _currentPosition;

  void refresh(){
    setState((){
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> _markers = [];
    StationViewModel stationViewModel = context.read<StationViewModel>();
    List<dynamic> fav = [];
    SharedPrefUtils.getFav().then((result) {
      fav = result;
    });

    return FutureBuilder(
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          final data = snapshot.data;
          _markers.add(Marker(
            point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
            width: 80,
            height: 80,
            builder: (context) => Icon(Icons.location_on, color: Colors.red,),
          ));

          return FutureBuilder(
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                final data = snapshot.data as Map<String, dynamic>;
                data["stations"].forEach((element) {
                  _markers.add(Marker(
                      point: LatLng(element['adresse']['latitude'], element['adresse']['longitude']),
                      width: 80,
                      height: 80,
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            _setStationSelectionne(element);
                          },
                          icon: Icon(Icons.local_gas_station, color: _isFav(element['id'], fav)?Colors.blue:Colors.green,),
                        );
                      }
                  ));
                });

                if(data["bestStation"] != null){
                  _markers.add(Marker(
                      point: LatLng(data["bestStation"]['adresse']['latitude'], data["bestStation"]['adresse']['longitude']),
                      width: 80,
                      height: 80,
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            _setStationSelectionne(data["bestStation"]);
                          },
                          icon: Icon(Icons.local_gas_station, color: _isFav(data["bestStation"]['id'], fav)?Colors.blue:Colors.deepOrangeAccent,),
                        );
                      }
                  ));
                }
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
                                //LocationMarkerLayerOptions(),
                              ],

                            )
                        ),
                        Panel(stationSelectionne: _stationSelectionne, fav: fav,  refreshMap : refresh)
                      ],
                    ),
                  ),
                );
              }else{
                return FlutterMap(
                  options: MapOptions(
                    plugins: [
                      LocationMarkerPlugin(),
                    ],
                    maxZoom: 18.4,
                    center: LatLng(0, 0),
                  ),
                );
              }
            },
            future: stationViewModel.getStationInPerimetre(_currentPosition.longitude, _currentPosition.latitude, widget.rangeValue, widget.tableauCarburant),
          );
        }else{
          return FlutterMap(
            options: MapOptions(
              plugins: [
                LocationMarkerPlugin(),
              ],
              maxZoom: 18.4,
              center: LatLng(0, 0),
            ),
          );
        }
      },
      future: _determinePosition().then((Position position) => _currentPosition = position),
    );
  }

  Future<SharedPreferences> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
          BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
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
        //_currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  _setStationSelectionne(element) {
    setState(() {
      _stationSelectionne = element;
    });
  }

  bool _isFav(id, List<dynamic> fav) {
    bool res = false;
    fav.forEach((element) {
      if(element["id"] == id){
        res = true;
      }
    });
    return res;
  }

}

