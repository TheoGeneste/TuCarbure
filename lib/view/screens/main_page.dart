import 'package:flutter/material.dart';
import 'package:tu_carbure/view/screens/login.dart';
import 'package:tu_carbure/view/screens/stationCreation.dart';
import 'package:tu_carbure/view/screens/map.dart';
import 'package:tu_carbure/view/screens/Profile.dart';

import '../../SharedPrefUtils.dart';
import '../../data/global_data.dart';
import '../viewmodels/carburant_viewmodel.dart';
import 'favoris.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _Rangevalue = 20;
  bool isLogged = false;
  String username = "";
  String token = "";
  String email = "";
  Map<String, bool> _tableauCarburantChecked = {"E85" : false};


  void _readGlobal() async{
    var global =  await GlobalData().getGlobal();
    username = global?["username"];
    token = global?["token"];
    email = global?["email"];
    isLogged = global?["isLogged"];
    print(token);
  }

  final List<Widget> _widget = [
    MyMap(rangeValue: 20, tableauCarburant: {}, ),
    const Favoris(),
    Login(),
  ];

  void _changePage(int index){
    _readGlobal();
    setState((){
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _readGlobal();
    _widget[0] = MyMap(rangeValue: _Rangevalue, tableauCarburant: _tableauCarburantChecked);
    _widget[2] = isLogged ? Profile() : Login();
    print(isLogged);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: _index == 0,
                child: IconButton(
                  icon: const Icon(Icons.filter_alt, color: Colors.green),
                  onPressed: (){
                    _scaffoldKey.currentState?.openDrawer();
                  },
                )
              ),
              Image.asset("assets/images/TuCarburesBanner.png", width: 200, height: 200),
              Visibility(
                visible: _index == 0 && isLogged,
                child: IconButton(
                  icon: const Icon(Icons.add,color: Colors.green),
                  onPressed: () {
                    Navigator.pushNamed(context, StationCreation.routeNames);
                  },
                )
              ),
            ],
          )
      ),
      body: Stack(
          children: <Widget>[_widget[_index],
      ]
      ),
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
            icon: isLogged? Icon(Icons.account_circle) : Icon(Icons.login,),
            label: 'Login',
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            const Padding(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child:Text(
                  "Filtres",
                  style: TextStyle(fontSize: 30),
                )
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child:Text(
                  "Type de carburant",
                  style: TextStyle(fontSize: 15),
                )
            ),
            // Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            //   child:ListeCarburantFilter()),
            FutureBuilder(builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                final data = snapshot.data as List;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var code = data[index]["code"];
                    _tableauCarburantChecked.putIfAbsent(code, () => false);

                    return Container(
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child : Text(
                                    data[index]['nom'] + " ("+ data[index]["code"] + ")",
                                    style:TextStyle(fontSize: 14)),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Checkbox(
                                    value: _tableauCarburantChecked[code],
                                    onChanged: (bool? value) {
                                      setState((){
                                        _tableauCarburantChecked[code] = value!;
                                    });
                                  },
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
                  return const Center(child: CircularProgressIndicator(),);
                }
              }, future: CarburantViewModel().getListeCarburant()
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => {
                    setPerimetreValue(_Rangevalue),
                    print(_tableauCarburantChecked),
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

  void setPerimetreValue(rangeValue){
    setState((){
    });
  }
}


