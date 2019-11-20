import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'appbarpopupmenubutton.dart';

//void main() => runApp(App());

void main() {

  fetch();

  runApp(App());

}

void fetch() async {
  final response = await http.get("https://gamesoftinteractive.com");

  developer.log("Status code: " + response.body.toString());
}

class App extends StatefulWidget {
  @override
  AppState createState() {
    return AppState();
  }
}

class AppState extends State<App> {

  int _bottomNavigationItemSelected = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: Stack(
          children: <Widget>[
            Visibility(child: SectionPlay(), visible: _bottomNavigationItemSelected == 0),
            Visibility(child: SectionGamers(), visible: _bottomNavigationItemSelected == 1)
          ],
        ),
        bottomNavigationBar: MyBottomNavigationBar(_bottomNavigationItemSelected, _onBottomNavigationItemSelected),
      ),
    );
  }

  void _onBottomNavigationItemSelected(int index) {
    setState(() {
      _bottomNavigationItemSelected = index;
    });
  }

}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('BonusPlay'),
      actions: <Widget>[
        AppBarPopupMenuButton()
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}



class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: Image(image: AssetImage('images/dummy_avatar.png'), width: 60, height: 60)),
                Center(child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text('account@bonusplay.app', style: TextStyle(fontSize: 18, color: Colors.blueAccent)),
                )),
                Center(child: Text('Balance: 10000 USD', style: TextStyle(fontSize: 14, color: Colors.grey))),
                Divider(thickness: 1),
                DrawerMenu()
              ],
            )
          )
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DrawerMenuItem('Account'),
        DrawerMenuItem('Support'),
        DrawerMenuItem('Sign out')
      ],
    );
  }
}

class DrawerMenuItem extends StatelessWidget {

  final String text;

  DrawerMenuItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Material(child: InkWell(
        //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(text, style: TextStyle(fontSize: 18)),
          highlightColor: Colors.grey,
          onTap: () {
            developer.log('Tap');
          },
    ));
  }
}

class MyBottomNavigationBar extends StatelessWidget {

  int _index = 0;

  Function(int) _onTap;

  MyBottomNavigationBar(int index, Function(int) onTap) {
    _index = index;
    _onTap = onTap;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), title: Text('Play')),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text('Gamers')),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text('Scores'))
      ],
      currentIndex: _index,
      onTap: _onTap,
    );
  }
}

class SectionPlay extends StatelessWidget {

  final List<String> entries = <String>['Game 1', 'Game 2', 'Game 3'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Row(
                children: <Widget>[
                  Container()
                ],
            ),
          );
        }
    );
  }
}

class SectionGamers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
            child: Text('Section gamers'),
            onPressed: () {
              Scaffold.of(context).showSnackBar(new SnackBar(content: Text('This is snackbar with notification')));
            }
        )
    );
  }


}