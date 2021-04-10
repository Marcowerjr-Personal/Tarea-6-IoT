import 'dart:convert';

import 'package:http/http.dart' as http;

Future getDeviceData() async {
  var respuesta = await http.get(
      Uri.parse("https://api-tarea6-iot.herokuapp.com/records/"),
      headers: {"Content-type": "application/json"});
  var data = jsonDecode(respuesta.body)['all_records'];
  return data;
}