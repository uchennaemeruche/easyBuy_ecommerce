import 'package:e_commerce_app/screens/account/account_screen.dart';
import 'package:e_commerce_app/screens/favProduct/favourite_product.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/product/product_screen.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int index;

  CustomBottomNavigation({Key key, this.index}) : super(key: key);
  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex;
  void navigateToScreen(String screen) {
    if (screen == "/products" || screen == "/home") {
      Navigator.pushReplacementNamed(context, screen);
    }
    Navigator.pushNamed(
      context,
      screen,
    );
  }

  List<BottomNavigationBarItem> navItems(currentIndex) {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/Gift Icon.svg",
          color: currentIndex == 0 ? kPrimaryColor : Colors.grey,
        ),
        title: Text("Home"),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/Parcel.svg",
          color: currentIndex == 1 ? kPrimaryColor : Colors.grey,
        ),
        title: Text("Products"),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/Heart Icon.svg",
          color: currentIndex == 2 ? kPrimaryColor : Colors.grey,
        ),
        title: Text("Favs"),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/icons/User Icon.svg",
          color: currentIndex == 3 ? kPrimaryColor : Colors.grey,
        ),
        title: Text("Account"),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: BottomNavigationBar(
          elevation: 10,
          currentIndex: currentIndex,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.black,
          unselectedIconTheme: IconThemeData(color: Colors.green),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[100],
          items: navItems(currentIndex),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            if (index == 3) {
              navigateToScreen(AccountScreen.routeName);
            } else if (index == 1 &&
                ModalRoute.of(context).settings.name != "/products") {
              navigateToScreen(ProductScreen.routeName);
            } else if (index == 0 &&
                ModalRoute.of(context).settings.name != "/home") {
              navigateToScreen(HomeScreen.routeName);
            } else if (index == 2) {
              navigateToScreen(FavoriteProduct.routeName);
            }
          }),
    );
  }
}
