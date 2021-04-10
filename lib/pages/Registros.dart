import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

import 'Control.dart';

bool toggle = true;

class RegistrosPage extends StatefulWidget {
  RegistrosPage({Key key}) : super(key: key);

  @override
  _RegistrosPageState createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.only(left: 5.0),
          child: Column(
            children: [
              JsonTable(
                registros,
                columns: [
                  JsonTableColumn("id_record", label: "ID de Registro"),
                  JsonTableColumn("status", label: "Estado del LED"),
                  JsonTableColumn("date", label: "Fecha de Registro")
                ],
                tableCellBuilder: (value) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: Colors.grey)),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 16.0, color: Colors.black),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}