import 'package:bonusplay/route_game.dart' as routes;
import 'package:bonusplay/route_settings.dart' as routes;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'appbarpopupmenubutton.dart';

//void main() => runApp(App());

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  AppState createState() {
    return AppState();
  }
}

class AppState extends State<App> {

  String _title = 'BonusPlay';

  String _sectionVisible = 'play';

  bool _bottomNavigationVisible = true;

  int _bottomNavigationItemSelected = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(_title),
        drawer: MyDrawer((String item) {
          switch(item) {
            case 'play':
              setState(() {
                _title = 'BonusPlay';
                _sectionVisible = 'play';
                _bottomNavigationVisible = true;
              });
              break;
            case 'account':
              setState(() {
                _title = 'Account';
                _sectionVisible = 'account';
                _bottomNavigationVisible = false;
              });
              break;
            case 'support':
              setState(() {
                _title = 'Support';
                _sectionVisible = 'support';
                _bottomNavigationVisible = false;
              });
              break;
          }
        }),
        body: Stack(
          children: <Widget>[
            Visibility(child: SectionAccount(), visible: _sectionVisible == 'account'),
            Visibility(child: SectionGames(), visible: _sectionVisible == 'play' && _bottomNavigationItemSelected == 0),
            Visibility(child: SectionPlayers(), visible: _sectionVisible == 'play' && _bottomNavigationItemSelected == 1)
          ],
        ),
        bottomNavigationBar: _bottomNavigationVisible ? MyBottomNavigationBar(_bottomNavigationItemSelected, _onBottomNavigationItemSelected) : null,
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

  final String title;

  MyAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        AppBarPopupMenuButton((String item) {
          switch(item) {
            case 'settings':
              Navigator.push(context, MaterialPageRoute(builder: (context) => routes.RouteSettings()));
              break;
            case 'sign_in':
              showDialog(context: context, builder: (BuildContext context) {
                return AlertSignIn(
                  onCancel: () {
                    Navigator.of(context).pop();
                  },
                  onOk: () {
                    Navigator.of(context).pop();
                  },
                );
              });
              break;
          }
        })
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}



class MyDrawer extends StatelessWidget {

  Function(String item) onMenuItemSelect;

  MyDrawer(this.onMenuItemSelect);

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
                DrawerMenuItem('Play', () {
                  Navigator.pop(context);
                  onMenuItemSelect('play');
                }),
                DrawerMenuItem('Account', () {
                  Navigator.pop(context);
                  onMenuItemSelect('account');
                }),
                DrawerMenuItem('Support', () {
                  Navigator.pop(context);
                  onMenuItemSelect('support');
                }),
                DrawerMenuItem('Sign out', () {
                  Navigator.pop(context);
                  Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Signed out successfully')));
                  onMenuItemSelect('sign_out');
                })
              ],
            )
          )
        ],
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {

  final String text;

  final Function onTap;

  DrawerMenuItem(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
          child: Container(
            child: Text(text, style: TextStyle(fontSize: 18)),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity
          ),
          highlightColor: Colors.grey,
          onTap: onTap
        )
    );
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
        BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), title: Text('Games')),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text('Players')),
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text('Scores'))
      ],
      currentIndex: _index,
      onTap: _onTap,
    );
  }
}

class SectionAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Email'),
          Container(
            padding: EdgeInsets.only(bottom: 12),
            child: TextField()
          ),
          Text('First name'),
          Container(
              padding: EdgeInsets.only(bottom: 12),
              child: TextField()
          ),
          Text('Last name'),
          Container(
              padding: EdgeInsets.only(bottom: 12),
              child: TextField()
          ),
        ],
      )
    );
  }
}

class SectionGames extends StatelessWidget {

  final List<GameItem> entries = <GameItem>[
    GameItem('Draw Car 3d', 'images/draw_car_3d.webp'),
    GameItem('Crazy Kick!', 'images/crazy_kick.webp'),
    GameItem('Swing Rider', 'images/swing_rider.webp'),
    GameItem('Crowd City', 'images/crowd_city.webp'),
    GameItem('Flip Dunk', 'images/flip_dunk.webp'),
    GameItem('Path Painter', 'images/path_painter.webp'),
    GameItem('Helix Jump', 'images/helix_jump.webp'),
    GameItem('Ball Blast', 'images/ball_blast.webp')
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return SectionGamesEntry(entries[index].title, entries[index].image);
        }
    );
  }
}

class GameItem {
  String title;
  String image;
  GameItem(this.title, this.image);
}

class SectionGamesEntry extends StatelessWidget {

  final String _text;
  final String _image;

  SectionGamesEntry(this._text, this._image);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => routes.RouteGame(_text, _image)));
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(child: Image(image: AssetImage(_image), width: 80, height: 80)),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                            Text('by Voodoo', style: TextStyle(fontSize: 12, color: Colors.blueGrey))
                          ])
                  )
                ]
            )),
      ),
    );

  }
}

class SectionPlayers extends StatelessWidget {

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

class AlertSignIn extends StatelessWidget {

  Function onCancel;

  Function onOk;

  AlertSignIn({this.onCancel, this.onOk});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sign In'),
      content: Text('Want to sign in?'),
      actions: <Widget>[
        FlatButton(child: Text('Cancel'), onPressed: onCancel),
        RaisedButton(child: Text('Ok', style: TextStyle(color: Colors.white)), onPressed: onOk)
      ],);
  }
}