import 'package:e_commerce_app/screens/signup/components/body.dart';
import 'package:e_commerce_app/widgets/circle_background.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBackground(),
          Body(),
        ],
      ),
    );
  }
}
