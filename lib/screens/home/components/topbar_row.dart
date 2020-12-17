import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:e_commerce_app/widgets/notification_icon.dart';
import 'package:e_commerce_app/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBarRow extends StatefulWidget {
  const TopBarRow({
    Key key,
  }) : super(key: key);

  @override
  _TopBarRowState createState() => _TopBarRowState();
}

class _TopBarRowState extends State<TopBarRow> {
  String searchCriteria = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SearchTextField(
          isHomeScreen: true,
          width: SizeConfig.screenWidth * 0.6,
          searchCriteria: searchCriteria,
          onChanged: (value) => setState(() => searchCriteria = value),
        ),
        Consumer<Cart>(
            builder: (BuildContext context, Cart cart, Widget child) {
          return NotificationIcon(
            onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
            icon: "assets/icons/Cart Icon.svg",
            notificationCount: cart.items.length,
          );
        }),
        NotificationIcon(
          icon: "assets/icons/Bell.svg",
          onTap: () => print("Notification tapped"),
          notificationCount: 0,
        )
      ],
    );
  }
}
