// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, use_key_in_widget_constructors

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:morningbrew/widgets/data_service.dart';
import 'package:morningbrew/widgets/models.dart';
import 'package:http/http.dart' as http;

class weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  WeatherRes? _res;
  @override
  void initState() {
    const duration = Duration(minutes: 1);
    getLocation();
    Timer.periodic(duration, (timer) {
      super.initState();
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
      child: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            getLocation();
          },
          child: Icon(Icons.refresh),
        ),
        body: Center(
          child: FutureBuilder(
            future: http.get(
              Uri.https("openweathermap.org", "/img/wn/10n@2x.png"),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    if (_res != null) ...[
                      CachedNetworkImage(imageUrl: '${_res?.iconURL}'),
                      Text('${_res?.cityName}'),
                      Text('Current: ${_res?.tempInfo.tempature} °F'),
                      Text('Low: ${_res?.tempInfo.minTemp} °F'),
                      Text('High: ${_res?.tempInfo.maxTemp}'),
                      Text('${_res?.weather.desc}'),
                    ] else
                      ...[]
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  getLocation() async {
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
    setState(() {
      _res = response;
    });
  }
}
