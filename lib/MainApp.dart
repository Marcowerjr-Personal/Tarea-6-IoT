import 'package:flutter/material.dart';
import 'NavBar.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes(context),
      onGenerateRoute: (RouteSettings settings) =>
          MaterialPageRoute(builder: (BuildContext context) => NavBar()),
    );
  }
}
