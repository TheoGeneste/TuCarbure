import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                              data[index]['nom'],
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = json.decode(prefs.get('fav').toString());
    return res;
  }

  void _removeFavoris(id) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> res = json.decode(prefs.get('fav').toString());

    var toRemove;
    res.forEach((element) {
      if(element["id"] == id){
        toRemove = element;
      }
    });
    res.remove(toRemove);

    String encodedMap = json.encode(res);
    prefs.setString('fav', encodedMap);

    setState((){
      _favoris = _getFavoris();
    });
  }


}
