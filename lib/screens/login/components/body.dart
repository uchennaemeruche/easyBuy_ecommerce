import 'dart:async';

import 'package:e_commerce_app/screens/forgotPassword/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/signup/signup.dart';
import 'package:e_commerce_app/services/auth-services.dart';
import 'package:e_commerce_app/services/form_field_validation.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:e_commerce_app/widgets/custom_suffix_icon.dart';
import 'package:e_commerce_app/widgets/custom_textbox.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:e_commerce_app/widgets/form_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:flutter_svg/flutter_svg.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
// final Future<FirebaseApp> _initialization = Firebase.initializeApp();

AuthService get authService => GetIt.I<AuthService>();

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: getProportionateScreenHeight(80.0),
            ),
            Text(
              "Welcome Back",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28.0),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            Text(
              "Sign in with your email and password \nor continue with social media",
              textAlign: TextAlign.center,
              // style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20.0),
                vertical: getProportionateScreenWidth(20.0),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Color(0xFFF6F7F9),
                border: Border.all(
                  color: Color(0xFFF6F7F9),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                children: [
                  SigninForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSocialIcon(
                          iconPath: "assets/icons/google-icon.svg",
                          onTap: authService.signInWithGoogle),
                      CustomSocialIcon(
                        iconPath: "assets/icons/facebook-2.svg",
                      ),
                      CustomSocialIcon(
                        iconPath: "assets/icons/twitter.svg",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16.0),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, SignupScreen.routeName),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: getProportionateScreenWidth(16.0)),
                        children: <TextSpan>[
                          TextSpan(
                            text: " Sign up",
                            style: TextStyle(color: kPrimaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class SigninForm extends StatefulWidget {
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final List<String> errors = [];
  bool isObscure = true;
  bool rememberMe = false;
  String email, password;
  String error = '';

  final _formKey = GlobalKey<FormState>();

  String addError(String error) {
    print("NEw Error: $error");
    setState(() {
      errors.add(error);
    });
    return error;
  }

  String removeError(error) {
    setState(() {
      errors.remove(error);
    });
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                hintText: "Enter your email",
                labelText: "Email",
                suffixIcon: "assets/icons/Mail.svg",
                isPasswordField: false,
                textFieldType: "email",
                textInputAction: TextInputAction.next,
                onSaved: (value) => email = value,
                onChanged: (value) {
                  FormFieldValidation(
                    addError: addError,
                    removeError: removeError,
                    errors: errors,
                    password: password,
                  ).onChangedTextField(value, "email");
                },
                validator: (value) {
                  FormFieldValidation(
                    addError: addError,
                    removeError: removeError,
                    errors: errors,
                    password: password,
                  ).validateField(value, "email");
                },
              ),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              CustomTextFormField(
                hintText: "Enter your password",
                labelText: "Password",
                suffixIcon: "assets/icons/Lock.svg",
                isPasswordField: true,
                textFieldType: "password",
                textInputAction: TextInputAction.done,
                onSaved: (value) => password = value,
                onChanged: (value) {
                  FormFieldValidation(
                    addError: addError,
                    removeError: removeError,
                    errors: errors,
                    password: password,
                  ).onChangedTextField(value, "password");
                },
                validator: (value) {
                  FormFieldValidation(
                    addError: addError,
                    removeError: removeError,
                    errors: errors,
                    password: password,
                  ).validateField(value, "password");
                },
              ),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value;
                      });
                    },
                    activeColor: kPrimaryColor,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, ForgotPassword.routeName),
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              FormErrors(errors: errors),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              DefaultButton(
                text: "Continue",
                onPressed: () async {
                  if (_formKey.currentState.validate() && errors.length < 1) {
                    _formKey.currentState.save();
                    dynamic result = await AuthService()
                        .signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        errors.add("An error occured");
                      });
                    } else {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }
                    return true;
                  } else {
                    print("Not valid");
                    return false;
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
