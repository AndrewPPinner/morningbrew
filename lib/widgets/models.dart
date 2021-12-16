import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:morningbrew/widgets/data_service.dart';
import 'package:morningbrew/widgets/weather.dart';

class TempRes {
  final double tempature;
  TempRes({required this.tempature});
  factory TempRes.fromJson(Map<String, dynamic> json) {
    final tempature = json['temp'];
    return TempRes(tempature: tempature);
  }
}

class WeatherType {
  final String desc;
  final String icon;

  WeatherType({required this.desc, required this.icon});
  factory WeatherType.fromJson(Map<String, dynamic> json) {
    final desc = json['description'];
    final icon = json['icon'];
    return WeatherType(desc: desc, icon: icon);
  }
}

class WeatherRes {
  final String cityName;
  final TempRes tempInfo;
  final WeatherType weather;

  String get iconURL {
    return 'https://openweathermap.org/img/wn/${weather.icon}@2x.png';
  }

  WeatherRes(
      {required this.cityName, required this.tempInfo, required this.weather});

  factory WeatherRes.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final tempInfoJson = json['main'];
    final tempInfo = TempRes.fromJson(tempInfoJson);
    final weatherTypeInfo = json['weather'][0];
    final weather = WeatherType.fromJson(weatherTypeInfo);
    return WeatherRes(
      cityName: cityName,
      tempInfo: tempInfo,
      weather: weather,
    );
  }
}

class AMDPrice {
  final double price;
  final double change;
  AMDPrice({required this.price, required this.change});
  factory AMDPrice.fromJson(Map<String, dynamic> json) {
    final price = json['c'];
    final change = json['d'];
    return AMDPrice(price: price, change: change);
  }
}

class TSLAPrice {
  final double price;
  final double change;
  TSLAPrice({required this.price, required this.change});
  factory TSLAPrice.fromJson(Map<String, dynamic> json) {
    final price = json['c'];
    final change = json['d'];
    return TSLAPrice(price: price, change: change);
  }
}

class SavedSettings {
  final String ticker1;
  final String ticker2;

  SavedSettings({required this.ticker1, required this.ticker2});
}
