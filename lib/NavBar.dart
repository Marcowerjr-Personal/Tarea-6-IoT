import 'package:flutter/material.dart';
import 'db/getDeviceData.dart';
import 'pages/Control.dart';
import 'pages/Registros.dart';
import 'StreamNavBar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Map device;

class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  StreamNavBar _bottomNavBarBloc;

  Future<void> _userInfo() async {
    device = await getDeviceData();
  }

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = StreamNavBar();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _userInfo();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Arduino LED Control App'),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.CONTROL:
                return ControlPage();
              case NavBarItem.REGISTROS:
                return RegistrosPage();
            }
            return ControlPage();
          },
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.green, boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.green.withOpacity(.1))
            ]),
            child: SafeArea(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 75.0, vertical: 8),
              child: StreamBuilder(
                stream: _bottomNavBarBloc.itemStream,
                initialData: _bottomNavBarBloc.defaultItem,
                builder:
                    (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
                  return GNav(
                    rippleColor: Colors.grey[300],
                    hoverColor: Colors.grey[100],
                    gap: 10,
                    tabBorder: Border.all(color: Colors.grey, width: 1),
                    activeColor: Colors.black,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration: Duration(milliseconds: 100),
                    tabBackgroundColor: Colors.grey[200],
                    onTabChange: _bottomNavBarBloc.pickItem,
                    selectedIndex: snapshot.data.index,
                    tabs: [
                      GButton(
                        icon: Icons.settings,
                        text: 'Control',
                      ),
                      GButton(
                        icon: Icons.receipt,
                        text: 'Registros',
                      )
                    ],
                  );
                },
              ),
            ))));
  }
}
