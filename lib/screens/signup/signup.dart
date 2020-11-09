import 'package:e_commerce_app/screens/otp/otp_screen.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:e_commerce_app/widgets/custom_textbox.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:e_commerce_app/widgets/form_error.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String email, password, confirmPassword;

  final List<String> errors = [];

  void addError(String error) {
    setState(() {
      errors.add(error);
    });
  }

  void removeError(error) {
    setState(() {
      errors.remove(error);
    });
  }

  onChangedTextField(value, fieldType) {
    if (fieldType == "email") {
      if (value.isNotEmpty && errors.contains(kEmailNullError)) {
        removeError(kEmailNullError);
      } else if (emailValidatorRegExp.hasMatch(value) &&
          errors.contains(kInvalidEmailError)) {
        removeError(kInvalidEmailError);
      }
      return null;
    } else if (fieldType == "password") {
      if (value.isNotEmpty && errors.contains(kPassNullError)) {
        removeError(kPassNullError);
      } else if (value.length > 5 && errors.contains(kShortPassError)) {
        removeError(kShortPassError);
      }
    } else if (fieldType == "confirm-password") {
      if (value == password && errors.contains(kMatchPassError)) {
        removeError(kMatchPassError);
      }
    }
  }

  validateField(value, fieldType) {
    if (fieldType == "email") {
      if (value.isEmpty && !errors.contains(kEmailNullError)) {
        addError(kEmailNullError);
      } else if (!emailValidatorRegExp.hasMatch(value) &&
          !errors.contains(kInvalidEmailError)) {
        addError(kInvalidEmailError);
      }
      return null;
    } else if (fieldType == "password") {
      if (value.isEmpty && !errors.contains(kPassNullError)) {
        addError(kPassNullError);
      } else if (value.length < 5 && !errors.contains(kShortPassError)) {
        addError(kShortPassError);
      }
      return null;
    } else if (fieldType == "confirm-password") {
      if (value != password && !errors.contains(kMatchPassError)) {
        addError(kMatchPassError);
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign up"),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20.0)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    Text("Register Account", style: headerTextStyle),
                    SizedBox(
                      height: getProportionateScreenHeight(8.0),
                    ),
                    Text(
                      "Enter your details below or sign up using\n your social media account",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: "Enter your email",
                            labelText: "Email",
                            suffixIcon: "assets/icons/Mail.svg",
                            isPasswordField: false,
                            onSaved: (value) => email = value,
                            onChanged: (value) {
                              onChangedTextField(value, "email");
                            },
                            validator: (value) {
                              validateField(value, "email");
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(20.0)),
                          CustomTextFormField(
                            hintText: "Enter your password",
                            labelText: "Password",
                            suffixIcon: "assets/icons/Lock.svg",
                            isPasswordField: true,
                            onSaved: (value) => password = value,
                            onChanged: (value) {
                              onChangedTextField(value, "password");
                            },
                            validator: (value) {
                              validateField(value, "password");
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(20.0)),
                          CustomTextFormField(
                            hintText: "Re-enter your password",
                            labelText: "Confirm Password",
                            suffixIcon: "assets/icons/Lock.svg",
                            isPasswordField: true,
                            onSaved: (value) => confirmPassword = value,
                            onChanged: (value) {
                              onChangedTextField(value, "confirm-password");
                            },
                            validator: (value) {
                              validateField(value, "confirm-password");
                            },
                          ),
                          FormErrors(errors: errors),
                          SizedBox(height: getProportionateScreenHeight(20.0)),
                          DefaultButton(
                            text: "Continue",
                            onPressed: () {
                              print("Hello");
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                Navigator.pushNamed(
                                    context, OtpScreen.routeName);
                              }
                            },
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.08),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomSocialIcon(
                                iconPath: "assets/icons/google-icon.svg",
                              ),
                              CustomSocialIcon(
                                iconPath: "assets/icons/facebook-2.svg",
                              ),
                              CustomSocialIcon(
                                iconPath: "assets/icons/twitter.svg",
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(20.0)),
                          Text(
                            "By continuing, you confirm that you agree\n with our Terms and Conditions",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
