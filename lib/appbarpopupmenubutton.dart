import 'package:bonusplay/route_settings.dart' as routes;
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class AppBarPopupMenuButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(value: 'settings', child: Text('Settings')),
        PopupMenuItem(value: 'rate', child: Text('Rate Us')),
        PopupMenuItem(value: 'signin', child: Text('Sign in'))
      ],
      onSelected: (String s) {
        switch(s) {
          case 'settings':
            Navigator.push(context, MaterialPageRoute(builder: (context) => routes.RouteSettings()));
        }
      }
    );
  }
  
}