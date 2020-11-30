import 'package:e_commerce_app/widgets/custom_suffix_icon.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText, hintText, suffixIcon;
  final ValueChanged onChanged;
  final FormFieldValidator validator;
  final FormFieldSetter onSaved;
  final bool isPasswordField;
  final String textFieldType;
  final String initialValue;
  final TextInputAction textInputAction;

  const CustomTextFormField({
    Key key,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.isPasswordField,
    this.textInputAction,
    this.textFieldType,
    this.initialValue = "",
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscure;

  @override
  void initState() {
    _isObscure = widget.isPasswordField ? true : false;
    super.initState();
  }

  TextInputType processTextField(textFieldType) {
    switch (textFieldType) {
      case "password":
        {
          return TextInputType.visiblePassword;
        }
        break;
      case "email":
        {
          return TextInputType.emailAddress;
        }
        break;
      case "description":
        {
          return TextInputType.multiline;
        }
        break;
      case "number":
        {
          return TextInputType.number;
        }
        break;
      default:
        {
          return TextInputType.name;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      obscureText: _isObscure,
      keyboardType: processTextField(widget.textFieldType),
      maxLines: widget.textFieldType == "description" ? 4 : 1,
      textInputAction: widget.textInputAction,
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
            if (widget.isPasswordField) {
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
