import 'package:flutter/material.dart';
import '../../data/profile_data.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();

  _getProfile(){
    var data = ProfileData().getProfile("test");
  }

  _setUsername(){
    return "test";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child:
          Center(
              child:  Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child:Text("Mon profile", style:TextStyle(fontSize: 30)),
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nom d\'utilisateur',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                        child: TextFormField(
                          controller: mailController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Mail',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                        child: TextFormField(
                          controller: telephoneController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Numero de téléphone',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                        child: TextFormField(
                          controller: nomController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nom',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                        child: TextFormField(
                          controller: prenomController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Prenom',
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Mot de passe',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                        child: TextFormField(
                          controller: passwordConfirmationController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Confirmation du mot de passe',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),
                          ),
                          child: const Text('Modifier'),
                        ),
                      ),
                    ],
                  ),
                ),
              ])
          )
      );
    }
  }
