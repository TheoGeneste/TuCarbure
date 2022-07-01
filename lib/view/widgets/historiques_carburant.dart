import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_carbure/view/viewmodels/historique_carburant_viewmodel.dart';

class HistoriquesCarburant extends StatelessWidget {
  String id;
  HistoriquesCarburant({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HistoriqueCarburantViewModel historiqueCarburantViewModel = context.read<HistoriqueCarburantViewModel>();
    print(historiqueCarburantViewModel);
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            print(snapshot.data);
            return Container(
              child: Text("oui")
            );
          } else {
            return CircularProgressIndicator();
          }
        },
        future: historiqueCarburantViewModel.getHistoCarburants(id),
    );
  }
}
