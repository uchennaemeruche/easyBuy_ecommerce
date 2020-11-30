import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/screens/account/account_screen.dart';
import 'package:e_commerce_app/screens/details/product_details.dart';
import 'package:e_commerce_app/screens/home/components/special_offer_card.dart';
import 'package:e_commerce_app/screens/home/components/topbar_row.dart';
import 'package:e_commerce_app/screens/product/product_screen.dart';
import 'package:e_commerce_app/services/database_service.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/bottom_navigation.dart';
import 'package:e_commerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> sliders = [
    {
      "imagePath": "assets/images/Image Banner 2.png",
      "title": "Smartphone\n",
      "subTitle": "18 Brands"
    },
    {
      "imagePath": "assets/images/Image Banner 3.png",
      "title": "Fashion\n",
      "subTitle": "24 Brands"
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<Product>>.value(
          value: DatabaseService().products,
          catchError: (BuildContext context, Object obj) {
            print(
                "Hello, an error occurred in the HomeScreen product stream builder $obj");
            return obj;
          },
        ),
        StreamProvider<List<Category>>.value(
          value: DatabaseService().categories,
          catchError: (BuildContext context, Object obj) {
            print(
                "Hello, an error occurred in the HomeScreen Category stream builder $obj");
            return obj;
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                TopBarRow(),
                SizedBox(
                  height: getProportionateScreenHeight(30.0),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20.0),
                      vertical: getProportionateScreenWidth(15.0)),
                  decoration: BoxDecoration(
                    color: Color(0xFF4A3298),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: "A Summer Surprise\n",
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Cashback 20%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(24.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30.0),
                ),
                Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(130.0),
                  // color:Colors.red,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      Category category = categories[index];
                      return ProductCategory(category: category, hasIcon: true);
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Builder(builder: (BuildContext context) {
                  final List<Category> categories =
                      Provider.of<List<Category>>(context);
                  if (categories != null)
                    return Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(50.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          Category category = categories[index];
                          return ProductCategory(
                            category: category,
                          );
                        },
                      ),
                    );
                  else
                    return Center(child: CircularProgressIndicator());
                }),
                SizedBox(
                  height: getProportionateScreenHeight(30.0),
                ),
                headerSection(
                  headerTitle: "Special for you",
                  func: () {
                    print("Special offers");
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20.0),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(130),
                  child: OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 20.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: sliders.length,
                      itemBuilder: (BuildContext context, int index) {
                        dynamic item = sliders[index];
                        return SpecialOfferCard(
                          imagePath: item["imagePath"],
                          title: item["title"],
                          subTitle: item["subTitle"],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30.0),
                ),
                headerSection(
                  headerTitle: "Popular Product",
                  func: () {
                    print("Popular Products");
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20.0),
                ),
                PopularProducts()
                // ProductCard()
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigation(index: 0),
      ),
    );
  }

  Widget headerSection({String headerTitle, Function func}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              headerTitle,
              style: headerTextStyle.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenWidth(20.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: func,
            child: Text(
              "See More",
              style: headerTextStyle.copyWith(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenWidth(17.0),
              ),
            ),
          ),
        ],
      );
}

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> products = Provider.of<List<Product>>(context);
    final List<Product> popularProducts = [];
    if (products != null)
      for (var product in products) {
        if (product != null && product.isPopular == true) {
          popularProducts.add(product);
        }
      }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (popularProducts != null)
            ...List.generate(
              popularProducts.length,
              (index) => ProductCard(
                product: popularProducts[index],
                width: 150.0,
                padding: 20.0,
              ),
            )
          else
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}

class ProductCategory extends StatelessWidget {
  ProductCategory({Key key, this.category, this.hasIcon = false})
      : super(key: key);

  final Category category;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return hasIcon
        ? Column(
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15.0)),
                margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(7.0),
                ),
                width: getProportionateScreenWidth(55.0),
                height: getProportionateScreenWidth(55.0),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SvgPicture.asset(category.iconPath),
              ),
              SizedBox(
                width: getProportionateScreenWidth(55.0),
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
            child: InputChip(
              disabledColor: kPrimaryLightColor,
              selected: false,
              label: Text(
                category.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              padding: EdgeInsets.only(right: 0.0),
              tooltip: 'Click to delete or edit',
            ),
          );
  }
}
