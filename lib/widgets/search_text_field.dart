import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final double width;
  final String searchCriteria;

  SearchTextField({
    Key key,
    this.width,
    this.searchCriteria = "Products",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // 60% of screen width
      // height: 50.0,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        onChanged: (value) {
          print("Value searched");
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search $searchCriteria..",
          prefixIcon: Icon(
            Icons.search,
            color: kSecondaryColor,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(10),
          ),
        ),
      ),
    );
  }
}
