import 'dart:convert';

import 'package:http/http.dart' as http;

class MarquesData{

   Future<String> getMarques() async {
    var url = Uri.parse('http://theslipe.myddns.me:8080/marques');
    var marques = await http.get(url);

    return marques.body;
  }
}
