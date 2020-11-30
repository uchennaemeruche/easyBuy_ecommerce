import 'package:e_commerce_app/screens/login/components/body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text("Sign In",),
      ),
      body:Body()
    );
  }
}

