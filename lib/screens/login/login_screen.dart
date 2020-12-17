import 'package:e_commerce_app/screens/login/components/body.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../../widgets/circle_background.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          AppBackground(),
          Body(),
        ],
      ),
    );
  }
}
