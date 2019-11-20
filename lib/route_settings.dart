import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class RouteSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SettingsBody(),
    );
  }
}

class SettingsBody extends StatefulWidget {

  @override
  SettingsBodyState createState() {
    return SettingsBodyState();
  }
}

class SettingsBodyState extends State<SettingsBody> {

  bool _firstOptionValue = true;
  bool _secondOptionValue = false;
  bool _thirdOptionValue = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SettingsItem("First option", "Apply this option if you want something", _firstOptionValue, onChanged: _onFirstOptionChanged),
          SettingsItem("Second option", "This option does nothing", _secondOptionValue, onChanged: (bool state) {
            setState(() {
              _secondOptionValue = state;
            });
          }),
          SettingsItem("Third option",
              "This option does nothing too but, has a little longer description", _thirdOptionValue, onChanged: (bool state) {
                setState(() {
                  _thirdOptionValue = state;
                });
              })
        ],
      ),
    );
  }

  void _onFirstOptionChanged(bool state) {
    setState(() {
      _firstOptionValue = state;
    });
  }
}

class SettingsItem extends StatelessWidget {

  String _title;

  String _description;

  bool _value;

  void Function(bool) onChanged;

  SettingsItem(String title, String description, bool value, {this.onChanged}) {
    _title = title;
    _description = description;
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text(_title, style: TextStyle(fontWeight: FontWeight.bold),), Text(_description)],
              )
            ),
            Switch(value: _value, onChanged: onChanged)
      ],
    )
    );
  }
}
