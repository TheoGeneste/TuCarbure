import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class StationsData{

   Future<String> getStationWithPerimetre(double longitude, double latitude, int perimetre) async {
    var url = Uri.parse('http://theslipe.myddns.me:8080/stations?latitue=$latitude&longitude=$longitude&distance=$perimetre');
    var stations = await http.get(url);
    print('Response status: ${stations.statusCode}');
    // var stations = await Dio().get("http://theslipe.myddns.me:8080/stations", queryParameters:qParams );
    return stations.body;
  }
}
