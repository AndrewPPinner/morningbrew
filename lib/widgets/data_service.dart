import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:morningbrew/widgets/models.dart';

class DataService {
  Future<WeatherRes> getWeather(String lat, String lon) async {
    final queryParameters = {
      'lat': lat,
      'lon': lon,
      'units': 'imperial',
      'appid': 'd1172525e77aebbb79846bda52cf2b23'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);
    final res = await http.get(uri);
    final json = jsonDecode(res.body);
    return WeatherRes.fromJson(json);
  }

  Future<AMDPrice> getAMD(String ticker1) async {
    final queryParameters = {
      'symbol': ticker1.toUpperCase(),
      'token': 'c409dcaad3iaf2seehk0'
    };

    final uri = Uri.https('finnhub.io', '/api/v1/quote', queryParameters);
    final res = await http.get(uri);
    final json = jsonDecode(res.body);
    return AMDPrice.fromJson(json);
  }

  Future<TSLAPrice> getTSLA(String ticker2) async {
    final queryParameters = {
      'symbol': ticker2.toUpperCase(),
      'token': 'c409dcaad3iaf2seehk0'
    };

    final uri = Uri.https('finnhub.io', '/api/v1/quote', queryParameters);
    final res = await http.get(uri);
    final json = jsonDecode(res.body);
    return TSLAPrice.fromJson(json);
  }

  Future getCoffee() async {
    final uri = Uri.http('192.168.50.129', '/');
    final res = await http.get(uri);
    String resBody = res.body;
    return resBody;
  }
}
