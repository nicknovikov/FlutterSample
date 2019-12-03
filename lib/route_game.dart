import 'package:flutter/material.dart';

class RouteGame extends StatelessWidget {

  String _title;

  final String _description = '''
The most addictive game!

Enter the arena and face the other holes in a fierce battle.
Eat everything in sight with your black hole and expand it to eat more! Show them who is the biggest hole in town!


LOCAL COUCH MULTIPLAYER FEATURE
Want to compete directly with your friends? Follow these four simple tasks:
- Step 1: Open the "Local Multiplayer" menu on the right and create a room
- Step 2: Make your friends join*
- Step 3: ???
- Step 4: Enjoy the battle!

*Bluetooth required. They need to be close enough to play.
  ''';

  String _image;

  RouteGame(this._title, this._image);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(title: Text('Game')),

      body: new SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image(image: AssetImage(_image), width: 120, height: 120),
                    Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                            Text('by Voodoo', style: TextStyle(fontSize: 12, color: Colors.blueGrey))
                          ],
                        )
                    )

                  ],
                ),
              ),
              Text(_description)
            ],
          )
        )
      )


    );
  }
}

