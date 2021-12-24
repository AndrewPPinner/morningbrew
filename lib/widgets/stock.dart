// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morningbrew/widgets/data_service.dart';
import 'package:morningbrew/widgets/models.dart';
import 'package:morningbrew/widgets/pref_service.dart';
import 'package:morningbrew/widgets/settings.dart';

class Stock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stockState();
}

class _stockState extends State<Stock> {
  AMDPrice? _responseAMD;
  TSLAPrice? _responseTSLA;
  bool upTSLA = false;
  bool upAMD = false;
  String? _ticker1Name;
  String? _ticker2Name;
  @override
  void initState() {
    _stock();
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
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                  ).then((value) => reload());
                },
              ),
            ],
          ),
          if (_responseAMD != null) ...[
            Image.network(
              'https://g.foolcdn.com/art/companylogos/square/$_ticker1Name.png',
              height: 75,
              width: 75,
            ),
            Text(_ticker1Name!),
            Text("${_responseAMD?.price} USD"),
            Text(
              "${_responseAMD?.change} USD",
              style: upAMD == true
                  ? TextStyle(color: Colors.green)
                  : TextStyle(color: Colors.red),
            ),
            Image.network(
              'https://g.foolcdn.com/art/companylogos/square/$_ticker2Name.png',
              height: 75,
              width: 75,
            ),
            Text(_ticker2Name!),
            Text('${_responseTSLA?.price} USD'),
            Text(
              '${_responseTSLA?.change} USD',
              style: upTSLA == true
                  ? TextStyle(color: Colors.green)
                  : TextStyle(color: Colors.red),
            ),
          ] else ...[
            CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            )
          ]
        ],
      ),
    );
  }

  Future<void> _stock() async {
    final _dataService = DataService();
    final settings = await getSettings();
    var ticker1 = settings.ticker1;
    var ticker2 = settings.ticker2;
    final ticker1Name = ticker1.toUpperCase();
    final ticker2Name = ticker2.toUpperCase();
    final responseAMD = await _dataService.getAMD(ticker1);
    final responseTSLA = await _dataService.getTSLA(ticker2);
    setState(() => {
          _ticker1Name = ticker1Name,
          _ticker2Name = ticker2Name,
          _responseAMD = responseAMD,
          _responseTSLA = responseTSLA,
          if (_responseTSLA!.change > 0)
            {upTSLA = true}
          else if (_responseTSLA!.change < 0)
            {upTSLA = false},
          if (_responseAMD!.change > 0)
            {upAMD = true}
          else if (_responseAMD!.change < 0)
            {upAMD = false}
        });
  }

  reload() {
    Timer(Duration(milliseconds: 500), () {
      _stock();
    });
  }
}
