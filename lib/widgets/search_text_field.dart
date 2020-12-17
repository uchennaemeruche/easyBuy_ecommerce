import 'package:e_commerce_app/screens/product/product_screen.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final double width;
  final String searchCriteria, hintText;
  final Function onChanged;
  final isHomeScreen;

  SearchTextField({
    Key key,
    this.width,
    this.searchCriteria,
    this.hintText = "Products",
    this.onChanged,
    this.isHomeScreen = false,
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
        onChanged: onChanged,
        onSubmitted: (value) {
          print("Submitted");
          if (isHomeScreen) {
            print("Product Screen called");
            Navigator.pushNamed(
              context,
              ProductScreen.routeName,
              arguments: ProductArguments(searchCriteria: searchCriteria),
            );
            // Navigator.pushReplacementNamed(context, ProductScreen.routeName);
          }
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search $hintText..",
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

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      // onPressed: () => Navigator.pop(context),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Column(
      children: [
        Container(
          child: Text("Hello there"),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }
}
