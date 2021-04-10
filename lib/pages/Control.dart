import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tarea_6_iot/db/getDeviceData.dart';

String estadoLed = "";
int idPost = 0;
String fechaRegistro = "";
var registros;

class ControlPage extends StatefulWidget {
  ControlPage({Key key}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  void initState() {
    super.initState();
    _getLastAlarmStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Divider(
            height: 100,
            color: Colors.white,
          ),
          Center(
            child: Text(
              'Estado del LED: $estadoLed',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Divider(
            height: 50,
            color: Colors.white,
          ),
          Center(
            child: Text(
              'Fecha de registro: $fechaRegistro',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Divider(
            height: 100,
            color: Colors.white,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () => _postAlarmStatus('ENCENDIDO'),
                child: Text(
                  "Encender",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    fixedSize: MaterialStateProperty.all(Size.fromHeight(50)))),
          ),
          Divider(
            color: Colors.white,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () => _postAlarmStatus('APAGADO'),
                child: Text("Apagar", style: TextStyle(fontSize: 20)),
                style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    fixedSize: MaterialStateProperty.all(Size.fromHeight(50)))),
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  _postAlarmStatus(String estado) async {
    var datos = jsonEncode({
      'id_record': ++idPost,
      'status': estado,
      'date':
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}"
    });
    var respuesta = await post(
        Uri.parse("https://api-tarea6-iot.herokuapp.com/new-record/"),
        headers: {"Content-type": "application/json"},
        body: datos);
    await _getLastAlarmStatus();
  }

  _getLastAlarmStatus() async {
    registros = await getDeviceData();
    setState(() {
      estadoLed = registros.last['status'];
      idPost = registros.last['id_record'];
      fechaRegistro = registros.last['date'];
    });
  }
}
