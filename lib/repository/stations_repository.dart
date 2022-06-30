import 'dart:convert';

import 'package:tu_carbure/data/stations_data.dart';

class StationRepository{
  Future<List<Map<String, dynamic>>> getStationWithPerimetre(longitude, latitude, perimetre, Map<String, bool> tableauCarburant) async {
    var stations = await StationsData().getStationWithPerimetre(longitude, latitude, perimetre, tableauCarburant);
    final parsed = List<Map<String, dynamic>>.from(json.decode(stations)['stations']);
    return parsed;
  }
}
