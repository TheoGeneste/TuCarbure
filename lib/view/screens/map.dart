import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:tu_carbure/view/viewmodels/stations_viewmodel.dart';

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
              builder: (context) => Icon(Icons.local_gas_station, color: Colors.green,),
            ));
          });
          return Center(
            child: Container(
              child: Column(
                children: [
                  Flexible(
                      child: FlutterMap(
                        options: MapOptions(
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
                        ],
                      )
                  )
                ],
              ),
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
      future: stationViewModel.getStationInPerimetre(_currentPosition.longitude, _currentPosition.latitude, 100),
    );
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
