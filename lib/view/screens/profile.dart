import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tu_carbure/view/screens/main_page.dart';

import '../../data/global_data.dart';
import '../../data/profile_data.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();

  _getProfile() async {
    var res = await ProfileData().getProfile();
    var r = jsonDecode(res) as Map<String, dynamic>;
    prenomController.text = r["prenom"];
    nomController.text = r["nom"];
  }

  _updateProfile() async {
    var res = await ProfileData()
        .updateProfile(nomController.text, prenomController.text);
  }

  @override
  Widget build(BuildContext context) {
    _getProfile();
    return SingleChildScrollView(
        child: Center(
            child: Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Text("Mon profile", style: TextStyle(fontSize: 30)),
      ),
      Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextFormField(
                controller: nomController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nom',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextFormField(
                controller: prenomController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Prenom',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  _updateProfile();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                ),
                child: const Text('Modifier'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ElevatedButton(
                onPressed: () async {
                  GlobalData().disconnect();
                  //TODO: Faire verif bien deco
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contex) => MainPage()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                ),
                child: const Text('Deconnexion'),
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}
