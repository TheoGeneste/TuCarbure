import 'dart:convert';

import 'package:tu_carbure/data/stations_data.dart';

class StationRepository {
  Future<Map<String, dynamic>> getStationWithPerimetre(longitude, latitude,
      perimetre, Map<String, bool> tableauCarburant) async {
    var stations = await StationsData().getStationWithPerimetre(
        longitude, latitude, perimetre, tableauCarburant);
    final parsed = Map<String, dynamic>.from(json.decode(stations));
    return parsed;
  }
}
