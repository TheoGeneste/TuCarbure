import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tu_carbure/data/favoris_data.dart';

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
                              data[index]['name'],
                              textAlign: TextAlign.center,
                              style:TextStyle(fontSize: 16)),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {
                            _removeFavoris(data[index]['id']);
                          }
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
    }, future: _favoris);
  }

  Future<List> _getFavoris() async {
    var json = await FavorisData().getFavoris();
    return json?["results"] as List;
  }


  void _removeFavoris(id) async {
    var json = await _getFavoris();
    json.removeWhere((item) => item['id'] == id);
    FavorisData().writeFavoris("{\"results\":"+ jsonEncode(json).toString() +"}");
    setState(){
      _favoris = _getFavoris();
    }
    print(_getFavoris());
  }


}
