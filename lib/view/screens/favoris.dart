import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favoris extends StatelessWidget {
  const Favoris({Key? key}) : super(key: key);

  _init() {
    throw UnimplementedError();
  }
  _read() {
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Center(
              child: Column(children: <Widget>[
                Text("Favoris", style:TextStyle(fontSize: 30)),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid
                        ),
                    children: [
                      TableRow(children: [
                        Column(children:[Text('Station', style: TextStyle(fontSize: 20.0))]),
                        Column(children:[Text('Favoris', style: TextStyle(fontSize: 20.0))]),
                      ]),
                      TableRow( children: [
                        Column(children:[Text('Leclerc')]),
                        Column(children:[ IconButton(icon: const Icon(Icons.star),
                          onPressed: () {
                          },
                        )]),
                      ]),
                      TableRow( children: [
                        Column(children:[Text('Carrefour')]),
                        Column(children:[ IconButton(icon: const Icon(Icons.star),
                          onPressed: () {
                          },
                        )]),
                      ]),
                    ],
                  ),
                ),
              ])
          )
    );
  }
}
