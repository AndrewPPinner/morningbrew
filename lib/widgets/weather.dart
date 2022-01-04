// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:morningbrew/widgets/data_service.dart';
import 'package:morningbrew/widgets/models.dart';

class weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  WeatherRes? _res;
  @override
  void initState() {
    const duration = Duration(minutes: 1);
    Timer(Duration(milliseconds: 500), () {
      getLocation();
    });

    Timer.periodic(duration, (timer) {
      initState();
    });
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
        children: [
          if (_res != null) ...[
            Image.network('${_res?.iconURL}'),
            Text('${_res?.cityName}'),
            Text('${_res?.tempInfo.tempature} °F'),
            Text('${_res?.weather.desc}'),
          ] else ...[
            CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            )
          ]
        ],
      ),
    );
  }

  void getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.changeSettings(distanceFilter: 800, interval: 120000);
    _locationData = await location.getLocation();
    String lat = _locationData.latitude.toString();
    String lon = _locationData.longitude.toString();
    final _dataService = DataService();
    final response = await _dataService.getWeather(lat, lon);
    setState(() => _res = response);
  }
}
