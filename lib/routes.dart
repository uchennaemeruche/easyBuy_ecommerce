
import 'package:e_commerce_app/screens/forgotPassword/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/login/login_screen.dart';
import 'package:e_commerce_app/screens/onboarding/splash_screen.dart';
import 'package:e_commerce_app/screens/otp/otp_screen.dart';
import 'package:e_commerce_app/screens/signup/signup.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName:(context) => SplashScreen(),
  SignupScreen.routeName:(context) => SignupScreen(),
  LoginScreen.routeName:(context) => LoginScreen(),
  ForgotPassword.routeName:(context) => ForgotPassword(),
  OtpScreen.routeName: (context) => OtpScreen(),

};
