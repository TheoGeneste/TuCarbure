import 'package:http/http.dart' as http;

class StationsData{

   Future<String> getStationWithPerimetre(double longitude, double latitude, int perimetre) async {
    var url = Uri.parse('http://theslipe.myddns.me:8080/stations?latitude=$latitude&longitude=$longitude&distance=$perimetre');
    var stations = await http.get(url);
    print('Response status: ${stations.body}');
    return stations.body;
  }
}
