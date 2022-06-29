import 'package:flutter/material.dart';

import '../../data/liste_carburant_data.dart';

class ListeCarburantFilter extends StatefulWidget {
  const ListeCarburantFilter({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListeCarburantFilterState();
}

class _ListeCarburantFilterState extends State<ListeCarburantFilter>{
  late Future<List> _ListeCarburant = _getListeCarburant();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
        print("snapshot.data");
        print(snapshot.data);
        final data = snapshot.data as List;
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 100),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child : Text(
                            data[index]['nom'] + " ("+ data[index]["code"] + ")",
                            textAlign: TextAlign.center,
                            style:TextStyle(fontSize: 16)),
                      ),
                      Expanded(
                        child: Checkbox(
                          value: true,
                          onChanged: (bool? value) {  },
                        )
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
    }, future: _getListeCarburant());
  }

  Future<List> _getListeCarburant() async {
    var json = await ListeCarburant().getListeCarburant();
    print(json);
    return json as List;
  }
}
