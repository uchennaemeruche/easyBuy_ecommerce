import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/screens/product/components/add_edit_category.dart';
import 'package:e_commerce_app/screens/product/components/add_edit_product.dart';
import 'package:e_commerce_app/screens/product/components/admin_product_list.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/notification_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends PreferredSize {
  final double rating;
  final bool hasRating;
  final bool hasLeading;
  final String appBarTitle;

  CustomAppBar(
      {this.rating,
      this.hasRating = true,
      this.appBarTitle,
      this.hasLeading = true});
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            !hasLeading
                ? SizedBox.shrink()
                : SizedBox(
                    width: getProportionateScreenWidth(40.0),
                    height: getProportionateScreenWidth(40.0),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
            hasRating ? SizedBox.shrink() : Text(appBarTitle),
            Spacer(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<Cart>(
                      builder: (BuildContext context, Cart cart, Widget child) {
                    return NotificationIcon(
                      onTap: () =>
                          Navigator.pushNamed(context, CartScreen.routeName),
                      icon: "assets/icons/Cart Icon.svg",
                      notificationCount: cart.items.length,
                    );
                  }),
                  NotificationIcon(
                    icon: "assets/icons/Bell.svg",
                    onTap: () => print("Notification tapped"),
                    notificationCount: 0,
                  ),
                  hasRating
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(15.0),
                              vertical: getProportionateScreenHeight(5.0)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(rating.toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              SizedBox(width: getProportionateScreenWidth(4.0)),
                              SvgPicture.asset("assets/icons/Star Icon.svg")
                            ],
                          ),
                        )
                      : SizedBox(
                          width: 50,
                          // padding: EdgeInsets.only(
                          //     right: getProportionateScreenWidth(20.0)),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(Icons.more_horiz),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: SizedBox.shrink(),
                            onChanged: (String option) {
                              if (option == "Add Product") {
                                addEditProduct(context: context);
                              } else if (option == "View Products") {
                                adminProductList(context);
                              } else if (option == "Categories") {
                                addEditCategory(context: context);
                              }
                            },
                            items: <String>[
                              'Add Product',
                              'View Products',
                              'Categories'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
