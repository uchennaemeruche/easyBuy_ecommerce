import 'package:e_commerce_app/screens/signup/signup.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_textbox.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:e_commerce_app/widgets/form_error.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<String> errors = [];
  String email;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(20.0),
            ),
            Text(
              "Forgot Password",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28.0),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            Text(
              "Please enter your email and we will send \nyou a link to reset your password",
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
                    onSaved:(value) => email = value,
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          errors.contains(kEmailNullError)) {
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
                      if (value.isEmpty) {
                        print("Valud is empty ");
                      }
                      if (value.isEmpty && !errors.contains(kEmailNullError)) {
                        print("EMpty field");
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
                  ),
                  FormErrors(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(20.0)),
                  DefaultButton(
                    text: "Continue",
                    onPressed: () {
                      print("Hello");
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      }
                    },
                  )
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, SignupScreen.routeName),
              child: RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: getProportionateScreenWidth(16.0)),
                    children: <TextSpan>[
                      TextSpan(
                          text: " Sign up",
                          style: TextStyle(color: kPrimaryColor))
                    ]),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
