import 'package:flutter/material.dart';
import 'package:tu_carbure/data/stations_data.dart';
import 'package:tu_carbure/view/viewmodels/stationsCarburants_viewmodel.dart';

import '../../data/liste_carburant_data.dart';
import 'package:tu_carbure/view/viewmodels/carburant_viewmodel.dart';

import '../../model/SaisiePrixParam.dart';

class SaisiePrix extends StatefulWidget {
  static const routeNames = "/saisie-prix";

  const SaisiePrix({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SaisiePrixState();
}

class _SaisiePrixState extends State<SaisiePrix>{
  List<TextEditingController> listeController = [];
  List<bool> listeValueDispo = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SaisiePrixParam;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: Text('Mise à jour des prix'),
          actions: <Widget>[],
        ),
      body:Form(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
        final data = snapshot.data as List;
        for (var i in data){
          listeController.add(TextEditingController());
          listeValueDispo.add(i["disponible"]);
        }

        print(listeValueDispo);

        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 60,
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Container(
                          constraints: BoxConstraints(minWidth: 150, maxWidth: 150),
                          child: Text(
                              data[index]['nom'],
                              style:TextStyle(fontSize: 16)
                          )
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                        child:Expanded(
                          child : TextFormField(
                            controller: listeController[index],
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
                        child:Expanded(
                          child : Checkbox(
                            onChanged: (bool? value) {
                              setState(() {
                                listeValueDispo[index] = value! ? value : false;
                              });
                            },
                            value: listeValueDispo[index],
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
    }, future: StationsCarburantsViewModel().getStationCarburant(args.station['id'])),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            StationsData().updateCarburant(listeController, args.station['id']);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(40),
          ),
          child: const Text('Ajouter'),
        ),
      ),
    ]
    )
    )
    );
  }

}
