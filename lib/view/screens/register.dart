import 'package:flutter/material.dart';

import '../../data/register_data.dart';

class Register extends StatelessWidget {
  static const routeNames = "/register";

  Register({Key? key}) : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  _register(context) {
    if (usernameController.text != "" &&
        mailController.text != "" &&
        passwordConfirmationController.text != "" &&
        passwordController.text != "") {
      if (passwordController.text == passwordConfirmationController.text) {
        RegisterData().register(mailController.text,
            passwordController.text, usernameController.text);
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => _popup(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        title: Text('Inscription'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(children: <Widget>[
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Nom d\'utilisateur',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  controller: mailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mail',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mot de passe',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  controller: passwordConfirmationController,
                  obscureText: true,
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
                    _register(context);

                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                  child: const Text('S\'inscrire'),
                ),
              ),
            ],
          ),
        ),
      ]))),
    );
  }
}

Widget _popup(BuildContext context) {
  return AlertDialog(
    title: const Text('Information'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Inscription reussi !"),
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pop(context);

        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Accepter'),
      ),
    ],
  );
}
