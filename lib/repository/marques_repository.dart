import 'dart:convert';
import '../data/marques_data.dart';

class MarquesRepository {
  Future<List<Map<String, dynamic>>> getListeMarques() async {
    var Marques = await MarquesData().getMarques();

    final parsed = List<Map<String, dynamic>>.from(json.decode(Marques));
    return parsed;
  }
}
