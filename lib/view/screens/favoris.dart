import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tu_carbure/data/favoris_data.dart';

class Favoris extends StatelessWidget {
  const Favoris({Key? key}) : super(key: key);

  Future<List> getFavoris() async {
    var json = await FavorisData().getFavoris();
    return json?["results"] as List;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot){
      print(snapshot.connectionState);
      print(snapshot.data);

      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
        final data = snapshot.data as List;
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 20,
                margin: EdgeInsets.symmetric(horizontal: 100),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child : Text(data[index]['name'], textAlign: TextAlign.left,),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {},

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
    }, future: getFavoris());
  }
}
