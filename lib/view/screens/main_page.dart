import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:tu_carbure/view/screens/map.dart';

import 'favoris.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  final List<Widget> _widget = [
    const MyMap(),
    const Favoris(),
  ];

  void _changePage(int index){
    setState((){
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset("assets/images/TuCarburesBanner.png", width: 200, height: 200),
              Icon(Icons.filter_alt, color: Colors.green,)
            ],
          )
      ),
      body: _widget[_index],
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _index,
      showUnselectedLabels: false,
      onTap: _changePage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          label: 'Stations Favoris',
        )
      ],
    ),
    );
  }
}
