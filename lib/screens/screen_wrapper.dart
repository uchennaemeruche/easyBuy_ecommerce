import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenWrapper extends StatelessWidget {
  static String routeName = "/wrapper";
  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);
    return user == null ? SplashScreen() : HomeScreen();
  }
}
