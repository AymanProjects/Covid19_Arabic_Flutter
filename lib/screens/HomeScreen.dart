import 'package:Covid_19_dashboard_flutter/Services/Covid19API.dart';
import 'package:Covid_19_dashboard_flutter/models/Country.dart';
import 'package:Covid_19_dashboard_flutter/screens/CountriesList.dart';
import 'package:Covid_19_dashboard_flutter/util/CountriesInArabic.dart';
import 'package:Covid_19_dashboard_flutter/util/Themes.dart';
import 'package:Covid_19_dashboard_flutter/widgets/CovidCard.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCountryName = 'World';
  bool isLoading = true;
  List<String> allCountriesSorted;

  @override
  void initState() {
    super.initState();
    allCountriesSorted = CountriesInArabic.names.entries.map((entry) {
      return entry.value;
    }).toList();
    allCountriesSorted.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Covid19API.getCountry(selectedCountryName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          isLoading = false;
        } else {
          isLoading = true;
        }
        Country country = snapshot.data ?? Country();
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _countrySelectButton(isLoading ? 'جاري التحميل' : country.getNameAR()),
                    ],
                  ),
                  Row(
                    children: [
                      CovidCard(
                        title: 'اجمالي الاصابات',
                        number: country.getTotalCases(),
                        numberColor: Themes.blue,
                        isLoading: isLoading,
                        isPrimaryCard: true,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      CovidCard(
                        title: 'الحالات الحرجة',
                        number: country.getCritical(),
                        numberColor: Themes.purple,
                        isLoading: isLoading,
                      ),
                      CovidCard(
                        title: 'الحالات النشطة',
                        number: country.getActive(),
                        numberColor: Themes.yello,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      CovidCard(
                        title: 'المتوفين اليوم',
                        number: country.getTodayDeaths(),
                        numberColor: Colors.white,
                        isLoading: isLoading,
                      ),
                      CovidCard(
                        title: 'المصابين اليوم',
                        number: country.getTodayCases(),
                        numberColor: Colors.white,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      CovidCard(
                        title: 'المتوفين',
                        number: country.getTotalDeaths(),
                        numberColor: Themes.red,
                        isLoading: isLoading,
                      ),
                      CovidCard(
                        title: 'المتعافين',
                        number: country.getRecovered(),
                        numberColor: Themes.green,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _countrySelectButton(String countryName) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0, top: 6, bottom: 6),
      child: GestureDetector(
        onTap: () async {
          String resultInArabic = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CountriesList(countries: allCountriesSorted),
            ),
          );
          MapEntry entry = CountriesInArabic.names.entries.firstWhere(
              (element) => element.value == resultInArabic,
              orElse: () => null);
          if (entry != null) {
            setState(() {
              selectedCountryName = entry.key;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
          child: Text(
            countryName ?? 'جاري التحميل',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'arb',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
