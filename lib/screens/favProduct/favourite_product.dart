import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/database_service.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/bottom_navigation.dart';
import 'package:e_commerce_app/widgets/custom_appbar.dart';
import 'package:e_commerce_app/widgets/product_card.dart';
import 'package:e_commerce_app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProduct extends StatefulWidget {
  static String routeName = "/favProduct";

  @override
  _FavoriteProductState createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  final String productCategory = "Fav Products";
  String searchCriteria = '';

  final List<Map<String, dynamic>> sortParams = [
    {"icon": Icons.format_list_bulleted, "isSelected": false},
    {"icon": Icons.view_comfy, "isSelected": true}
  ];

  double cardWidth = 160.0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int countRow = (width / cardWidth).toInt();

    return StreamProvider<List<Product>>.value(
        value: DatabaseService().products,
        catchError: (BuildContext context, Object obj) {
          return obj;
        },
        builder: (BuildContext context, Widget child) {
          List<Product> products = Provider.of<List<Product>>(context);
          List<Product> favProducts;
          if (products != null)
            favProducts = products
                .where((product) => product.isFavourite == true)
                .toList();

          List<Product> searchableProducts = [];
          return Scaffold(
            backgroundColor: Color(0xFFF5F6F9),
            appBar: CustomAppBar(
              hasRating: false,
              hasLeading: false,
              appBarTitle: "Favorite Products",
            ),
            body: SafeArea(
              child: favProducts != null && favProducts.length <= 0
                  ? Center(
                      child: Text("Oops! you don't have any favourite item"),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(15.0)),
                              Text(
                                "Shop the best $productCategory deals",
                                // "Authentic World Cup Kits",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0,
                                  wordSpacing: 0,
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(30.0)),
                              SearchTextField(
                                hintText: productCategory,
                                searchCriteria: searchCriteria,
                                onChanged: (value) {
                                  setState(() => searchCriteria = value);
                                },
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(30.0)),
                              Row(
                                children: [
                                  ...List.generate(
                                    sortParams.length,
                                    (index) => IconButton(
                                      color: sortParams[index]['isSelected'] ==
                                              true
                                          ? Colors.blueGrey
                                          : Colors.black,
                                      splashRadius: 20.0,
                                      icon: Icon(sortParams[index]["icon"]),
                                      onPressed: () {
                                        setState(() {
                                          sortParams.forEach((item) {
                                            item['isSelected'] = false;
                                          });
                                          sortParams[index]['isSelected'] =
                                              true;
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                  FlatButton(
                                      onPressed: () =>
                                          setState(() => searchCriteria = ''),
                                      child: Text("Clear Search")),
                                  Text("FILTER",
                                      style: TextStyle(
                                        color: Colors.blueGrey[300],
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(
                                      width: getProportionateScreenWidth(10.0)),
                                  Text("\$2,000"),
                                ],
                              ),
                              Builder(builder: (BuildContext context) {
                                if (favProducts != null) {
                                  searchableProducts = favProducts
                                      .where((product) =>
                                          product.name.toLowerCase().contains(
                                                searchCriteria.toLowerCase(),
                                              ) ||
                                          product.description
                                              .toLowerCase()
                                              .contains(
                                                searchCriteria.toLowerCase(),
                                              ) ||
                                          product.categories.any(
                                            (category) => category
                                                .toLowerCase()
                                                .contains(
                                                  searchCriteria.toLowerCase(),
                                                ),
                                          ))
                                      .toList();
                                } else
                                  searchableProducts = null;

                                return searchableProducts != null
                                    ? GridView.count(
                                        primary: false,
                                        padding: const EdgeInsets.all(1.5),
                                        crossAxisCount: countRow,
                                        childAspectRatio: 0.60,
                                        mainAxisSpacing: 1.0,
                                        crossAxisSpacing: 10.0,
                                        children: [
                                          ...List.generate(
                                            searchableProducts.length,
                                            (index) => ProductCard(
                                              product:
                                                  searchableProducts[index],
                                            ),
                                          )
                                        ],
                                        shrinkWrap: true,
                                      )
                                    : Center(
                                        child: CircularProgressIndicator());
                              })
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            bottomNavigationBar: CustomBottomNavigation(index: 2),
          );
        });
  }
}
