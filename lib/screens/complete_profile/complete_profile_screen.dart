import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  static String routeName = "/complete-profile";
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Profile"),
      ),
    );
  }
}
