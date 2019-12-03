import 'package:flutter/material.dart';

class AppBarPopupMenuButton extends StatelessWidget {

  final Function(String item) onSelected;

  AppBarPopupMenuButton(this.onSelected);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(value: 'settings', child: Text('Settings')),
        PopupMenuItem(value: 'rate', child: Text('Rate Us')),
        PopupMenuItem(value: 'sign_in', child: Text('Sign in'))
      ],
      onSelected: onSelected,
    );
  }
  
}