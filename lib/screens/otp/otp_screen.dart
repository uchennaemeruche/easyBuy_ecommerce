import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = "/otp";
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("OTP Verification")),
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20.0)),
            child: SingleChildScrollView(
                          child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Text(
                    "OTP Verification",
                    style: headerTextStyle,
                  ),
                  Text("We sent your code to your email: abc@***"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "This code will expire in ",
                        style: TextStyle(color: kTextColor),
                      ),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 30.0, end: 0.0),
                        duration: Duration(seconds: 30),
                        builder: (context, value, child) => Text(
                            "00:${value.toInt()}",
                            style: TextStyle(color: kPrimaryColor)),
                        onEnd: () {},
                      )
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.15),
                  Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildSizedBox(
                          isAutoFocus: true,
                          focusNode: null,
                          nextNode: pin2FocusNode,
                        ),
                        buildSizedBox(
                          isAutoFocus: false,
                          focusNode: pin2FocusNode,
                          nextNode: pin3FocusNode,
                        ),
                        buildSizedBox(
                          isAutoFocus: false,
                          focusNode: pin3FocusNode,
                          nextNode: pin4FocusNode,
                        ),
                        buildSizedBox(
                            isAutoFocus: false,
                            focusNode: pin4FocusNode,
                            nextNode: null),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.15),

                  DefaultButton(
                    text: "Continue",
                    onPressed: () {
                      
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.20),
                  GestureDetector(
                    onTap: (){},
                    child: Text("Resend OTP Code",)
                  )
                ],
              ),
            ),
          ),
        )));
  }

  SizedBox buildSizedBox(
      {bool isAutoFocus, FocusNode focusNode, FocusNode nextNode}) {
    return SizedBox(
      width: getProportionateScreenWidth(60.0),
      child: TextFormField(
          maxLength: 1,
          autofocus: isAutoFocus,
          obscureText: true,
          focusNode: !isAutoFocus ? focusNode : null,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
          ),
          decoration: otpInputDecoration,
          onChanged: (value) {
            if (focusNode == pin4FocusNode) {
              pin4FocusNode.unfocus();
            } else {
              nextField(value: value, focusNode: nextNode);
            }
          }),
    );
  }
}
