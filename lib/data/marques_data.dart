import 'dart:convert';

import 'package:http/http.dart' as http;

class StationsData{

   Future<String> getStationWithPerimetre() async {
    var url = Uri.parse('http://theslipe.myddns.me:8080/marques');
    var stations = await http.get(url);
    return stations.body;
  }
}
