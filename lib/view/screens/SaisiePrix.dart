import 'package:flutter/material.dart';

import '../../data/liste_carburant_data.dart';
import 'package:tu_carbure/view/viewmodels/carburant_viewmodel.dart';

class SaisiePrix extends StatefulWidget {
  static const routeNames = "/saisie-prix";

  const SaisiePrix({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SaisiePrixState();
}

class _SaisiePrixState extends State<SaisiePrix>{

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
        final data = snapshot.data as List;

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child : Text(
                            data[index]['nom'] + " ("+ data[index]["code"] + ")",
                            style:TextStyle(fontSize: 16)),
                      ),
                      Expanded(
                        child : TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Prix',
                            ),
                        ),
                      ),

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
    }, future: CarburantViewModel().getListeCarburant()); //Remplacer par le bon appel api avec lid de la station
  }

}
