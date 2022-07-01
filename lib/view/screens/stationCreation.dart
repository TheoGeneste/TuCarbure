import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tu_carbure/data/stations_data.dart';
import 'package:tu_carbure/view/widgets/liste_marques_selector.dart';
import 'package:tu_carbure/view/widgets/liste_carburant_saisie_prix.dart';

import '../viewmodels/carburant_viewmodel.dart';

class StationCreation extends StatelessWidget {
  static const routeNames = "/creation-station";
  StationCreation({Key? key}) : super(key: key);

  TextEditingController stationNameController = TextEditingController();
  TextEditingController stationDescriptionController = TextEditingController();
  TextEditingController rueController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController codePostalController = TextEditingController();

  List<TextEditingController> listeController = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        title: Text('Find Devices'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
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
                      child: TextFormField(
                        controller: stationNameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Marque de la station',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                      child: TextFormField(
                        controller: stationDescriptionController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Description de la station',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                      child: TextFormField(
                        controller: rueController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Rue',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                      child: TextFormField(
                        controller: villeController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Ville',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        controller: codePostalController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Code postal',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:32, vertical: 16),
                      child: FutureBuilder(builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                          final data = snapshot.data as List;
                          for (var i in data){
                            listeController.add(TextEditingController());
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  height: 60,
                                  child: InkWell(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            constraints: BoxConstraints(minWidth: 200, maxWidth: 200),
                                            child: Text(
                                                data[index]['nom'],
                                                style:TextStyle(fontSize: 16)
                                            )
                                        ),
                                        Container(
                                          constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                                          child:Expanded(
                                            child : TextFormField(
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                                              ],
                                              controller: listeController[index],
                                              decoration: const InputDecoration(
                                                border: UnderlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              );
                            },
                            itemCount: data.length,
                            padding: const EdgeInsets.all(8),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator(),);
                        }
                      }, future: CarburantViewModel().getListeCarburant()),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          StationsData().addStation(stationNameController.text, stationDescriptionController.text, rueController.text, villeController.text, codePostalController.text, listeController);
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
          ),
      ),
    );
  }
}
