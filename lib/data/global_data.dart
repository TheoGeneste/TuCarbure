import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class GlobalData {
  writeGlobal(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/global.json');
    await file.writeAsString(text);
  }

  Future<Map<String, dynamic>?> getGlobal() async {
    String text = "";
    Map<String, dynamic>? decode = null;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/global.json');
      text = await file.readAsString();
      decode = jsonDecode(text) as Map<String, dynamic>;
    } catch (e) {
      print("Couldn't read file");
    }
    return decode;
  }

  Future<void> saveLogin(String username, String email, String token,
      String password, bool isLogged) async {
    var map = {
      "username": username,
      "token": token,
      "email": email,
      "isLogged": isLogged,
      "password": password
    };
    writeGlobal(jsonEncode(map));
  }

  Future<void> disconnect() async {
    saveLogin("", "", "", "", false);
  }
}
