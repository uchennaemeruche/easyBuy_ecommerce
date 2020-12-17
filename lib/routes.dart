import 'package:e_commerce_app/screens/account/account_screen.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/screens/details/product_details.dart';
import 'package:e_commerce_app/screens/favProduct/favourite_product.dart';
import 'package:e_commerce_app/screens/forgotPassword/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/login/login_screen.dart';
import 'package:e_commerce_app/screens/onboarding/splash_screen.dart';
import 'package:e_commerce_app/screens/otp/otp_screen.dart';
import 'package:e_commerce_app/screens/product/product_screen.dart';
import 'package:e_commerce_app/screens/screen_wrapper.dart';
import 'package:e_commerce_app/screens/signup/signup.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  ScreenWrapper.routeName: (context) => ScreenWrapper(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProductDetails.routeName: (context) => ProductDetails(),
  CartScreen.routeName: (context) => CartScreen(),
  AccountScreen.routeName: (context) => AccountScreen(),
  ProductScreen.routeName: (context) => ProductScreen(),
  FavoriteProduct.routeName: (context) => FavoriteProduct(),
};
