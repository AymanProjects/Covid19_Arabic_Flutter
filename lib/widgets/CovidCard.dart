import 'package:Covid_19_dashboard_flutter/util/Themes.dart';
import 'package:flutter/material.dart';

class CovidCard extends StatelessWidget {
  final String title;
  final String number;
  final Color numberColor;
  final bool isLoading;
  final bool isPrimaryCard;

  CovidCard({
    this.title,
    this.number,
    this.numberColor,
    this.isLoading,
    this.isPrimaryCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        padding: EdgeInsets.only(
          left: 32,
          right: 32,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: Themes.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400], blurRadius: 10.0, spreadRadius: 1)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FittedBox(
              child: Text(
                title,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'arb',
                  fontSize: isPrimaryCard ? 20.0 : 16.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            isLoading
                ? Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(numberColor),
                    ),
                  )
                : FittedBox(
                    child: Text(
                      number ?? 'غير معروف',
                      style: TextStyle(
                        color: numberColor,
                        fontWeight: FontWeight.bold,
                        fontSize: isPrimaryCard ? 26.0 : 20.0,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
