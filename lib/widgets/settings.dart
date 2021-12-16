// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningbrew/widgets/home_page.dart';
import 'package:morningbrew/widgets/models.dart';
import 'package:morningbrew/widgets/pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _prefService = PrefService();
  final _tickerController1 = TextEditingController();
  final _tickerController2 = TextEditingController();
  bool _validate1 = false;
  bool _validate2 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff34CBB9),
          elevation: 0,
          title: const Center(
            child: Text('Settings'),
          ),
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: TextField(
                controller: _tickerController1,
                decoration: InputDecoration(
                  labelText: 'Stock Ticker 1',
                  errorText: _validate1 ? 'Value Can\'t Be Empty' : null,
                ),
              ),
            ),
            ListTile(
              title: TextField(
                controller: _tickerController2,
                decoration: InputDecoration(
                  labelText: 'Stock Ticker 2',
                  errorText: _validate2 ? 'Value Can\'t Be Empty' : null,
                ),
              ),
            ),
            TextButton(onPressed: _saveSettings, child: Text('Save Settings'))
          ],
        ),
      ),
    );
  }

  void _saveSettings() async {
    Navigator.pop(context);
    setState(() {
      _tickerController1.text.isEmpty ? _validate1 = true : _validate1 = false;
      _tickerController2.text.isEmpty ? _validate2 = true : _validate2 = false;
    });
    final newSettings = SavedSettings(
        ticker1: _tickerController1.text, ticker2: _tickerController2.text);
    _prefService.savedSettings(newSettings);
  }
}
