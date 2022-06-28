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
                          child: DropdownButtonFormField(
                              value: "One",
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Marque',
                              ),
                              onChanged: (String? newValue) {

                              },
                              items: <String>['One', 'Two', 'Free', 'Four',]
                                  .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }
                              ).toList(),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Distance Maximale',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid
                            ),
                            children: [
                              TableRow( children: [
                                Column(children:[Text('Carburant', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('Prix', style: TextStyle(fontSize: 20.0))]),
                              ]),
                            ],
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
                            child: const Text('Ajouter'),
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
