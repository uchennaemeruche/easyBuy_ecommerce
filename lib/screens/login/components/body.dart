import 'package:e_commerce_app/screens/forgotPassword/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/signup/signup.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:e_commerce_app/widgets/custom_suffix_icon.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:e_commerce_app/widgets/form_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              SizedBox(height: getProportionateScreenHeight(20.0),),
              Text(
                "Welcome Back",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28.0),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: getProportionateScreenHeight(8.0),),
              Text(
                "Sign in with your email and password \nor continue with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              SigninForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSocialIcon(iconPath: "assets/icons/google-icon.svg",),
                  CustomSocialIcon(iconPath: "assets/icons/facebook-2.svg",),
                  CustomSocialIcon(iconPath: "assets/icons/twitter.svg",),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(16.0),),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, SignupScreen.routeName),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(color: kTextColor, fontSize: getProportionateScreenWidth(16.0)),
                    children: <TextSpan>[
                      TextSpan(text: " Sign up", style: TextStyle(color: kPrimaryColor))
                    ] 
                  ),
                ),
              )
            ],
          ),
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

  final _formKey = GlobalKey<FormState>();

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
      obscureText: isObscure,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length > 5 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.length < 5 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        //  labelText and hintText does'nt work for flutter version less than 1.20.*
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          child: CustomSuffixIcon(
            iconPath: "assets/icons/Lock.svg",
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        //  labelText and hintText does'nt work for flutter version less than 1.20.*
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          iconPath: "assets/icons/Mail.svg",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  buildEmailTextFormField(),
                  SizedBox(height: getProportionateScreenHeight(20.0)),
                  buildPasswordTextFormField(),
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
            onTap: () => Navigator.pushNamed(context, ForgotPassword.routeName),
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
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
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
