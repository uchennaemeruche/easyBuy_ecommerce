import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:flutter/material.dart';

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    @required this.imagePath,
    @required this.title,
    @required this.subTitle,
  }) : super(key: key);

  final imagePath;
  final title;
  final subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(100.0),
      width: getProportionateScreenWidth(242.0),
      margin: EdgeInsets.only(right: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFF343434).withOpacity(0.4),
                    Color(0xFF343434).withOpacity(0.15)
                  ])),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15.0),
                  vertical: getProportionateScreenHeight(18.0)),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                      text: title,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: subTitle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}