import 'package:flutter/material.dart';
import 'package:tu_carbure/view/viewmodels/historique_carburant_viewmodel.dart';

class HistoriquesCarburant extends StatelessWidget {
  String id;

  HistoriquesCarburant({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<DataRow> histoCarburantRows = [];
          List data = snapshot.data as List;
          data.forEach((element) {
            DateTime dt = DateTime.parse(element['date']);
            element['carburants']['details'].forEach((detail) {
              histoCarburantRows.add(DataRow(cells: [
                DataCell(Text(detail["nom"])),
                DataCell(Text(detail["prix"].toString() + "€")),
                DataCell(Text(dt.toString())),
              ]));
            });
          });
          return Container(
            child: DataTable(
              columnSpacing: 12,
              horizontalMargin: 12,
              sortColumnIndex: 2,
              sortAscending: true,
              columns: [
                DataColumn(
                    label: Text(
                  "Type Essence",
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  "Prix",
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  "Date",
                  textAlign: TextAlign.center,
                )),
              ],
              rows: histoCarburantRows,
            ),
          );
        } else {
          return Container(child: const CircularProgressIndicator());
        }
      },
      future: HistoriqueCarburantViewModel().getHistoCarburants(id),
    );
  }
}
