import 'package:e_commerce_app/widgets/custom_suffix_icon.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText, hintText, suffixIcon;
  final ValueChanged onChanged;
  final FormFieldValidator validator;
  final FormFieldSetter onSaved;
  final bool isPasswordField;

  const CustomTextFormField(
      {Key key,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.onChanged,
      this.onSaved,
      this.validator, this.isPasswordField})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscure,
      keyboardType: widget.isPasswordField ? TextInputType.visiblePassword : TextInputType.emailAddress,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        //  labelText and hintText does'nt work for flutter version less than 1.20.*
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: InkWell(
          onTap: () {
            if(widget.isPasswordField){
              setState(() {
              _isObscure = !_isObscure;
            });
            }
          },
          child: CustomSuffixIcon(
            iconPath: widget.suffixIcon,
          ),
        ),
      ),
    );
  }
}
