import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../data/favoris_data.dart';

class Panel extends StatelessWidget {
  var stationSelectionne;
  Panel({Key? key, required this.stationSelectionne}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: stationSelectionne['marque'] != null ? true : false ,
      child: SlidingUpPanel(
        body: Center(child: stationSelectionne['marque'] != null ? Text(stationSelectionne['marque']['nom']) : Text("Pas de station selectionne"),),
        panelBuilder: (sc) => _panel(sc, context),
      ),
    );
  }

  Widget _panel(ScrollController sc, BuildContext context) {
    List<DataRow> prixCarburants = [];
    stationSelectionne["carburants"]["details"].forEach((element) {
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
                    icon: const Icon(Icons.star_outline),
                    onPressed: () {
                      print(stationSelectionne);
                      FavorisData().addFavoris(stationSelectionne['marque']['nom'], stationSelectionne['id']);
                    },
                  ),
                  Spacer(flex: 1,),
                  Text(
                    stationSelectionne['marque'] != null ? stationSelectionne['marque']['nom']: "pas de station",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                    ),
                  ),
                  Spacer(flex: 1,),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Text(
                  stationSelectionne['adresse'] != null ? stationSelectionne['adresse']['rue'] + ", " + stationSelectionne['adresse']['codePostal'] + " " + stationSelectionne['adresse']['ville']: "pas de station",
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
            )
          ],
        )
      );
    }
}
