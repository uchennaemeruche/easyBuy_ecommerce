import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:e_commerce_app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBarRow extends StatelessWidget {
  const TopBarRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SearchTextField(width: SizeConfig.screenWidth * 0.6),
        // CustomSocialIcon(
        //   iconPath: "assets/icons/Cart Icon.svg",
        //   padding: 7.0,
        //   margin: 0,
        //   width: 46.0,
        //   height: 46.0,
        //   onTap: () {
        //     Navigator.pushNamed(context, CartScreen.routeName);
        //   },
        // ),
        Stack(
          overflow: Overflow.visible,
          children: [
            CustomSocialIcon(
              iconPath: "assets/icons/Cart Icon.svg",
              padding: 7.0,
              margin: 0,
              width: 46.0,
              height: 46.0,
              onTap: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
            Positioned(
              top: -3,
              right: 2,
              child: Container(
                width: getProportionateScreenWidth(15.0),
                height: getProportionateScreenHeight(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.0, color: Colors.white),
                ),
                child: Consumer<Cart>(
                  builder: (BuildContext context, Cart cart, Widget child) {
                    return Text(
                      "${cart.items.length}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(10.0),
                        height: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
            )
          ],
        ),
        Stack(
          overflow: Overflow.visible,
          children: [
            CustomSocialIcon(
              iconPath: "assets/icons/Bell.svg",
              padding: 7.0,
              margin: 0,
              width: 46.0,
              height: 46.0,
              onTap: () {
                print("Cart");
              },
            ),
            Positioned(
              top: -3,
              right: 2,
              child: Container(
                width: getProportionateScreenWidth(15.0),
                height: getProportionateScreenHeight(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.0, color: Colors.white),
                ),
                child: Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenWidth(10.0),
                    height: 1.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
