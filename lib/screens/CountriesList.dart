import 'package:flutter/material.dart';

class CountriesList extends StatelessWidget {
  final List<String> countries;
  CountriesList({this.countries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Text(
          'جميع الدول',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.clear, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: countries.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              child: new Card(
                child: ListTile(
                  title: Text(
                    countries[index],
                    textDirection: TextDirection.rtl,
                  ),
                  onTap: () {
                    Navigator.of(context).pop(countries[index]);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
