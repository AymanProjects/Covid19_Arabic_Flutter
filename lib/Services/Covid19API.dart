import 'package:Covid_19_dashboard_flutter/models/Country.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';

class Covid19API {
  static final String url =
      'https://coronavirus-19-api.herokuapp.com/countries/';

  static Future<Country> getCountry(String name) async {
    Http.Response response = await Http.get('$url$name');
    Map jsonData = jsonDecode(response.body);
    if (jsonData == null) return null;
    return Country.fromJson(jsonData);
  }
}
