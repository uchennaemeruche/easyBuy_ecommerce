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

class ProductScreen extends StatefulWidget {
  static String routeName = "/products";

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final String productCategory = "Electronics";

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
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Color(0xFFF5F6F9),
            appBar: CustomAppBar(
              hasRating: false,
              hasLeading: false,
              appBarTitle: "All Electronics deals",
            ),
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: getProportionateScreenHeight(15.0)),
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
                        SizedBox(height: getProportionateScreenHeight(30.0)),
                        SearchTextField(searchCriteria: productCategory),
                        SizedBox(height: getProportionateScreenHeight(30.0)),
                        Row(
                          children: [
                            ...List.generate(
                              sortParams.length,
                              (index) => IconButton(
                                color: sortParams[index]['isSelected'] == true
                                    ? Colors.blueGrey
                                    : Colors.black,
                                splashRadius: 20.0,
                                icon: Icon(sortParams[index]["icon"]),
                                onPressed: () {
                                  setState(() {
                                    sortParams.forEach((item) {
                                      item['isSelected'] = false;
                                    });
                                    sortParams[index]['isSelected'] = true;
                                  });
                                },
                              ),
                            ),
                            Spacer(),
                            Text("FILTER",
                                style: TextStyle(
                                  color: Colors.blueGrey[300],
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(width: getProportionateScreenWidth(10.0)),
                            Text("\$2,000"),
                          ],
                        ),
                        Builder(builder: (BuildContext context) {
                          List<Product> products =
                              Provider.of<List<Product>>(context);

                          return products != null
                              ? GridView.count(
                                  primary: false,
                                  padding: const EdgeInsets.all(1.5),
                                  crossAxisCount: countRow,
                                  childAspectRatio: 0.60,
                                  mainAxisSpacing: 1.0,
                                  crossAxisSpacing: 10.0,
                                  children: [
                                    ...List.generate(
                                      products.length,
                                      (index) => ProductCard(
                                        product: products[index],
                                      ),
                                    )
                                  ],
                                  shrinkWrap: true,
                                )
                              : Center(child: CircularProgressIndicator());
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomNavigation(index: 1),
          );
        });
  }
}
