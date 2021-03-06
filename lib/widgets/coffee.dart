// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, use_key_in_widget_constructors

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:morningbrew/widgets/data_service.dart';

class Coffee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CoffeeState();
}

class _CoffeeState extends State<Coffee> {
  String? _response;
  bool visableText = false;
  bool loading = true;
  @override
  void initState() {
    notFound();
    _coffee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              var url = Uri.parse('http://192.168.50.129/H');
              http.get(url);
              _coffee();
            },
            child: const Text('ON'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var url = Uri.parse('http://192.168.50.129/L');
              http.get(url);
              _coffee();
            },
            child: const Text('OFF'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
          ),
          Image(
            image: AssetImage(
                'images/PinClipart.com_coffee-pot-clip-art_2896273.png'),
          ),
          if (_response != null) ...[
            Text(
              'Your coffee pot is ' + _response!.toLowerCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ] else ...[
            Padding(
              padding: const EdgeInsets.all(5),
              child: Visibility(
                visible: loading,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
            Visibility(
              visible: visableText,
              child: Text('No coffee pot found'),
            )
          ]
        ],
      ),
    );
  }

  Future<void> _coffee() async {
    final _dataService = DataService();
    final response = await _dataService.getCoffee();
    setState(() => {
          _response = response,
        });
  }

  notFound() {
    Timer(Duration(seconds: 20), () {
      setState(() {
        visableText = true;
        loading = false;
      });
    });
  }
}
