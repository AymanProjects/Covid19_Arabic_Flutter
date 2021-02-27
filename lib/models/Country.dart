import 'package:Covid_19_dashboard_flutter/util/CountriesInArabic.dart';

class Country {
  final String nameEN;
  final String totalCases;
  final String recovered;
  final String active;
  final String todayCases;
  final String todayDeaths;
  final String totalDeaths;
  final String critical;

  Country({
    this.nameEN,
    this.totalCases,
    this.recovered,
    this.active,
    this.todayCases,
    this.totalDeaths,
    this.todayDeaths,
    this.critical,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      nameEN: json["country"],
      totalCases: json["cases"]?.toString(),
      recovered: json["recovered"]?.toString(),
      active: json["active"]?.toString(),
      todayCases: json["todayCases"]?.toString(),
      totalDeaths: json["deaths"]?.toString(),
      todayDeaths: json["todayDeaths"]?.toString(),
      critical: json["critical"]?.toString(),
    );
  }

  String formatNumber(String number) {
    if (number == null || number == 'null') return null;
    if (number.length > 3)
      return formatNumber(number.substring(0, number.length - 3)) +
          "," +
          number.substring(number.length - 3, number.length);
    else
      return number;
  }

  String getNameEN() => nameEN;
  String getNameAR() => CountriesInArabic.names[nameEN];
  String getTotalCases() => formatNumber(totalCases);
  String getRecovered() => formatNumber(recovered);
  String getActive() => formatNumber(active);
  String getTodayCases() => formatNumber(todayCases);
  String getTodayDeaths() => formatNumber(todayDeaths);
  String getTotalDeaths() => formatNumber(totalDeaths);
  String getCritical() => formatNumber(critical);
}
