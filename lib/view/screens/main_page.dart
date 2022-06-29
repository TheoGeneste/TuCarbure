import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tu_carbure/view/screens/login.dart';
import 'package:tu_carbure/view/screens/stationCreation.dart';
import 'package:tu_carbure/view/screens/map.dart';
import 'package:tu_carbure/view/screens/login.dart';

import 'favoris.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _Rangevalue = 50;


  final List<Widget> _widget = [
    const MyMap(),
    const Favoris(),
    Login(),
  ];


  void _changePage(int index){
    setState((){
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                child: IconButton(
                  icon: const Icon(Icons.filter_alt, color: Colors.green),
                  onPressed: (){
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                visible: _index == 0
              ),
              Image.asset("assets/images/TuCarburesBanner.png", width: 200, height: 200),
              Visibility(
                child: IconButton(
                  icon: const Icon(Icons.add,color: Colors.green),
                  onPressed: () {
                    Navigator.pushNamed(context, StationCreation.routeNames);
                  },
                ),
                visible: _index == 0
              ),
            ],
          )
      ),
      body: Stack(children: <Widget>[_widget[_index],
        Visibility(
            child: SlidingUpPanel(
              panel: Center(child: Text("This is the sliding Widget"),),
            ),
            visible: _index == 0
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        showUnselectedLabels: false,
        onTap: _changePage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map,),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Stations Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login,),
            label: 'Login',
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Padding(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child:Text(
                  "Filtres",
                  style: TextStyle(fontSize: 30),
                )
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child:Text(
                  "Distance maximale",
                  style: TextStyle(fontSize: 15),
                )
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child:Text(
                  _Rangevalue.toString() + " km",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:5, vertical: 20),
              child: Slider(
                min: 0,
                max: 100,
                value: _Rangevalue.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _Rangevalue = value.round();
                  });
                },
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child:Text(
                  "Type de carburant",
                  style: TextStyle(fontSize: 15),
                )
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                  child: const Text('Filtrer'),
                ),
            ),
          ],
        ),
      )
    );
  }
}


