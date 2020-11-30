import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/otp/otp_screen.dart';
import 'package:e_commerce_app/services/auth-services.dart';
import 'package:e_commerce_app/services/form_field_validation.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:e_commerce_app/widgets/custom_textbox.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:e_commerce_app/widgets/form_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String email, password, confirmPassword, name;

  final List<String> errors = [];
  // User user = FirebaseAuth.instance.currentUser;

  void addError(String error) {
    print("NEw Error: $error");
    setState(() {
      errors.add(error);
    });
  }

  void removeError(error) {
    setState(() {
      errors.remove(error);
    });
  }

  @override
  void initState() {
    super.initState();
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
                    // Text("User: ${user.displayName}"),
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
                            hintText: "Full name",
                            labelText: "Fullname",
                            suffixIcon: "assets/icons/User.svg",
                            isPasswordField: false,
                            textFieldType: "text",
                            onSaved: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                            onChanged: (value) {
                              // onChangedTextField(value, "email");
                              FormFieldValidation(
                                      addError: addError,
                                      removeError: removeError,
                                      errors: errors,
                                      password: password)
                                  .onChangedTextField(value, "name");
                            },
                            validator: (value) {
                              // validateField(value, "email");
                              FormFieldValidation(
                                      addError: addError,
                                      removeError: removeError,
                                      errors: errors,
                                      password: password)
                                  .validateField(value, "name");
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(20.0)),
                          CustomTextFormField(
                            hintText: "Enter your email",
                            labelText: "Email",
                            suffixIcon: "assets/icons/Mail.svg",
                            isPasswordField: false,
                            textFieldType: "email",
                            onSaved: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            onChanged: (value) {
                              // onChangedTextField(value, "email");
                              FormFieldValidation(
                                      addError: addError,
                                      removeError: removeError,
                                      errors: errors,
                                      password: password)
                                  .onChangedTextField(value, "email");
                            },
                            validator: (value) {
                              // validateField(value, "email");
                              FormFieldValidation(
                                      addError: addError,
                                      removeError: removeError,
                                      errors: errors,
                                      password: password)
                                  .validateField(value, "email");
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(20.0)),
                          CustomTextFormField(
                            hintText: "Enter your password",
                            labelText: "Password",
                            suffixIcon: "assets/icons/Lock.svg",
                            isPasswordField: true,
                            textFieldType: "password",
                            onSaved: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                              FormFieldValidation(
                                      addError: addError,
                                      removeError: removeError,
                                      errors: errors,
                                      password: password)
                                  .onChangedTextField(value, "password");
                            },
                            validator: (value) {
                              FormFieldValidation(
                                      addError: addError,
                                      removeError: removeError,
                                      errors: errors,
                                      password: password)
                                  .validateField(value, "password");
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(20.0)),
                          CustomTextFormField(
                            hintText: "Re-enter your password",
                            labelText: "Confirm Password",
                            suffixIcon: "assets/icons/Lock.svg",
                            isPasswordField: true,
                            textFieldType: "password",
                            onSaved: (value) => confirmPassword = value,
                            onChanged: (value) {
                              FormFieldValidation(
                                addError: addError,
                                removeError: removeError,
                                errors: errors,
                                password: password,
                              ).onChangedTextField(value, "confirm-password");
                            },
                            validator: (value) {
                              FormFieldValidation(
                                      addError: addError,
                                      removeError: removeError,
                                      errors: errors,
                                      password: password)
                                  .validateField(value, "confirm-password");
                            },
                          ),
                          FormErrors(errors: errors),
                          SizedBox(height: getProportionateScreenHeight(20.0)),
                          DefaultButton(
                            text: "Continue",
                            onPressed: () async {
                              if (_formKey.currentState.validate() &&
                                  errors.length < 1) {
                                _formKey.currentState.save();
                                dynamic result = await AuthService()
                                    .signupWithEmailAndPassword(
                                        email, password, name);
                                if (result == null) {
                                  setState(() {
                                    errors.add("Could not create new user");
                                  });
                                } else {
                                  Navigator.pushNamed(
                                    context,
                                    HomeScreen.routeName,
                                  );
                                }
                              } else {
                                print("Not valid");
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
