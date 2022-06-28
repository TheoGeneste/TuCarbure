import 'package:flutter/material.dart';

class StationCreation extends StatelessWidget {
  const StationCreation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Center(
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child:Text("Création d'une station", style:TextStyle(fontSize: 30)),
                ),
                Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                        )
                      ]
                    ),
                ),
              ])
          )
    );
  }
}
