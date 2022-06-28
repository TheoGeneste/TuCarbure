import 'dart:convert';

import 'package:tu_carbure/data/stations_data.dart';
import 'package:tu_carbure/model/station.dart';

class StationRepository{
  Future<void> getStationWithPerimetre(longitude, latitude, perimetre) async {
    var stations = await StationsData().getStationWithPerimetre(longitude, latitude, perimetre);
    final parsed = List<Map<String, dynamic>>.from(json.decode(stations.toString()));
    print(parsed);
    // (jsonDecode(stations.toString())).map((e){
    //   print(e);
    // });
  }
}
