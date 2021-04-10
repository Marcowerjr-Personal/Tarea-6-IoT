import 'package:flutter/material.dart';
import 'NavBar.dart';

Map<String, WidgetBuilder> routes(BuildContext context) {
  Map<String, WidgetBuilder> rutas = {
    '/': (BuildContext context) => NavBar(),
  };
  return rutas;
}
