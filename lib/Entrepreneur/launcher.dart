import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noppon/Business/business_list_user.dart';
import 'package:noppon/Entrepreneur/account.dart';
import 'package:noppon/User/favorite.dart';
import 'package:noppon/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noppon/Business/business_me.dart';

class Launcher extends StatefulWidget {
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
  List<Widget> _pageWidget = <Widget>[
    Business_List_User(),
    Business_Me(),
    Favorite(),
    Account(),
  ];

  Future<bool> _onWillPop() async {
    return (await LogoutMethod(context)) ?? false;
  }

  LogoutMethod(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Image.asset(
              'assets/flutter-icon.png',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            Text('  แจ้งเตือน')
          ]),
          content: Text("คุณต้องการออกจากระบบ ใช่หรือไม่?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "ไม่ใช่",
                style: new TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
            FlatButton(
              child: Text(
                "ใช่",
                style: new TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.home),
        title: Text('Home'),
        backgroundColor: Colors.black54),
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.userAlt),
        title: Text('Me'),
        backgroundColor: Colors.black54),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        title: Text('Favorite'),
        backgroundColor: Colors.black54),
    BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.userAlt),
        title: Text('Account'),
        backgroundColor: Colors.black54),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: _pageWidget.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: _menuBar,
            iconSize: 20,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
        ));
  }
}
