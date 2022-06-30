import 'package:http/http.dart' as http;

class ListeCarburant{

   Future<String> getListeCarburant() async {
    var url = Uri.parse("http://theslipe.myddns.me:8080/carburants");
    var carburants = await http.get(url);
    return carburants.body;
  }
}
