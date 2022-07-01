import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tu_carbure/SharedPrefUtils.dart';
import 'package:tu_carbure/view/widgets/historiques_carburant.dart';

import '../../data/favoris_data.dart';
import '../../data/global_data.dart';
import '../../model/SaisiePrixParam.dart';
import '../screens/SaisiePrix.dart';
import '../viewmodels/historique_carburant_viewmodel.dart';

class Panel extends StatefulWidget {
  var stationSelectionne;
  List fav;
  Function refreshMap;
  Panel({Key? key, required this.stationSelectionne, required this.fav, required this.refreshMap}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PanelState();

}
class _PanelState extends State<Panel>{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLogged = false;
  String username = "";
  String token = "";
  String email = "";

  void _readGlobal() async{
    var global =  await GlobalData().getGlobal();
    username = global?["username"];
    token = global?["token"];
    email = global?["email"];
    isLogged = global?["isLogged"];
    print(token);
  }


  @override
  Widget build(BuildContext context) {

    _readGlobal();


    return Visibility(
      visible: widget.stationSelectionne['marque'] != null ? true : false ,
      child: SlidingUpPanel(
        body: Center(child: widget.stationSelectionne['marque'] != null ? Text(widget.stationSelectionne['marque']['nom']) : Text("Pas de station selectionne"),),
        panelBuilder: (sc) => _panel(sc, context),
      ),
    );
  }

  Widget _panel(ScrollController sc, BuildContext context) {
    List<DataRow> prixCarburants = [];
    widget.stationSelectionne["carburants"]["details"].forEach((element) {
      prixCarburants.add(
          DataRow(
            cells: [
              DataCell(Text(element["nom"])),
              DataCell(Text(element["prix"].toString() + "€")),
              element["disponible"] ? DataCell(Icon(Icons.done,)) : DataCell(Icon(Icons.close, color: Colors.red,))
            ]
          )
      );
    });

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Container(
              child: Row(
                children: [
                  IconButton(
                    icon: _isFav(widget.stationSelectionne['id'], widget.fav) ? Icon(  Icons.star ): Icon(Icons.star_outline),
                    onPressed: () {
                      if(_isFav(widget.stationSelectionne['id'], widget.fav)){
                        FavorisData().removeFavoris(widget.stationSelectionne['id']);
                      }else{
                        FavorisData().addFavoris(widget.stationSelectionne['marque']['nom'], widget.stationSelectionne['id']);
                      }
                      widget.refreshMap();
                      // setState((){
                      //   SharedPrefUtils.getFav().then((result) {
                      //     widget.fav = result;
                      //   });
                      // });
                    },
                  ),
                  Spacer(flex: 1,),
                  Text(
                    widget.stationSelectionne['marque'] != null ? widget.stationSelectionne['marque']['nom']: "pas de station",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                    ),
                  ),
                  Spacer(flex: 1,),
                  Visibility(
                    visible: isLogged,
                      child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            SaisiePrix.routeNames,
                            arguments: SaisiePrixParam(widget.stationSelectionne)
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Text(
                  widget.stationSelectionne['adresse'] != null ? widget.stationSelectionne['adresse']['rue'] + ", " + widget.stationSelectionne['adresse']['codePostal'] + " " + widget.stationSelectionne['adresse']['ville']: "pas de station",
                )
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: DataTable(
                columnSpacing: 12,
                horizontalMargin: 12,
                columns: [
                  DataColumn(label: Text("Type Essence")),
                  DataColumn(label: Text("Prix")),
                  DataColumn(label: Text("Disponibilité")),
                ],
                rows: prixCarburants,
              ),
            ),
            Container(
              child:HistoriquesCarburant(id: widget.stationSelectionne['id']),
            ),
          ],
        )
      );
    }

  bool _isFav(id, List<dynamic> fav) {
    bool res = false;
    fav.forEach((element) {
      if(element["id"] == id){
        res = true;
      }
    });
    return res;
  }
}
