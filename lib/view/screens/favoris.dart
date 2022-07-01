import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../SharedPrefUtils.dart';

class Favoris extends StatefulWidget {
  const Favoris({Key? key}) : super(key: key);

  @override
  State<Favoris> createState() => _FavorisState();
}

class _FavorisState extends State<Favoris>{
  late Future<List> _favoris = _getFavoris();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
        final data = snapshot.data as List;

        List<DataRow> rows = [];
        data.forEach((element) {
          rows.add(DataRow(
              cells: [
                DataCell(Text(element['nom'])),
                DataCell(IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () {
                      _removeFavoris(element['id']);
                    }
                ))
              ]
          )
          );
        });

       return Container(
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child : DataTable(
                            columns: [
                              DataColumn(label: Text("Nom de la Station")),
                              DataColumn(label: Text(""))
                          ], rows: rows,
                          )
                      ),
                    ],
                  ),
                )
            );
      } else {
        return Center(child: CircularProgressIndicator(),);
      }
    }, future: _favoris);
  }

  Future<List> _getFavoris() async {

    return SharedPrefUtils.getFav();
  }

  void _removeFavoris(id) async {

    SharedPrefUtils.removeFav(id);

    setState((){
      _favoris = _getFavoris();
    });
  }


}
