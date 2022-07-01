import 'package:flutter/material.dart';

import '../viewmodels/carburant_viewmodel.dart';

class ListeCarburantFilter extends StatefulWidget {
  const ListeCarburantFilter({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListeCarburantFilterState();
}

class _ListeCarburantFilterState extends State<ListeCarburantFilter> {
  var _tableauCarburantChecked = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final data = snapshot.data as List;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                var code = data[index]["code"];
                _tableauCarburantChecked.add({code: false});
                return Container(
                    child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            data[index]['nom'] +
                                " (" +
                                data[index]["code"] +
                                ")",
                            style: TextStyle(fontSize: 14)),
                      ),
                      Expanded(
                          flex: 2,
                          child: Checkbox(
                            value: _tableauCarburantChecked[index][code],
                            onChanged: (bool? value) {
                              setState(() {
                                _tableauCarburantChecked[index][code] = value;
                              });
                            },
                          )),
                    ],
                  ),
                ));
              },
              itemCount: data.length,
              padding: const EdgeInsets.all(8),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: CarburantViewModel().getListeCarburant());
  }
}
