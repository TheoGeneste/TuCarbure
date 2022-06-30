import 'package:flutter/material.dart';

import '../viewmodels/marques_viewmodel.dart';

class ListeMarques extends StatefulWidget {
  const ListeMarques({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListeMarquesState();
}

class _ListeMarquesState extends State<ListeMarques>{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot){

        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          var data = <String>[];
          for (var d in snapshot.data as List){
            if(!data.contains(d['nom'].toLowerCase()))
              if(data.length < 10)
              data.add(d['nom'].toLowerCase());
          }
          return DropdownButtonFormField(
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Marque',
            ),
            onChanged: (String? newValue) {
            },
            items:data
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        } else{
          return CircularProgressIndicator();
        }
      },
      future: MarquesViewModel().getListeMarques(),
    );

  }

}
