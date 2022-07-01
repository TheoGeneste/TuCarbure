import 'package:http/http.dart' as http;

class ListeCarburant{

   Future<String> getListeCarburant() async {
    var url = Uri.parse("http://theslipe.myddns.me:8080/carburants");
    var carburants = await http.get(url);
    return carburants.body;
  }

   Future<String> getCarburantsHistorique(id) async {
    var url = Uri.parse("http://theslipe.myddns.me:8080/stations/$id/historique");
    var histoCarburants = await http.get(url);
    return histoCarburants.body;
  }

}
