import 'package:flutter/material.dart';

import '../viewmodels/carburant_viewmodel.dart';

class ListeCarburantSaisiePrix extends StatefulWidget {
  const ListeCarburantSaisiePrix({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListeCarburantSaisiePrixState();
}

class _ListeCarburantSaisiePrixState extends State<ListeCarburantSaisiePrix> {
  List<TextEditingController> listeController = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final data = snapshot.data as List;
            for (var i in data) {
              listeController.add(TextEditingController());
            }

            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 60,
                    child: InkWell(
                      child: Row(
                        children: <Widget>[
                          Container(
                              constraints:
                                  BoxConstraints(minWidth: 200, maxWidth: 200),
                              child: Text(data[index]['nom'],
                                  style: TextStyle(fontSize: 16))),
                          Container(
                            constraints:
                                BoxConstraints(minWidth: 100, maxWidth: 100),
                            child: Expanded(
                              child: TextFormField(
                                controller: listeController[index],
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              },
              itemCount: data.length,
              padding: const EdgeInsets.all(8),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: CarburantViewModel().getListeCarburant());
  }
}
