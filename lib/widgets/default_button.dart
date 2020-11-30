import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color color;

  const DefaultButton(
      {Key key, this.text, this.onPressed, this.color = kPrimaryColor})
      : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: widget.color,
        child: isLoading
            ? CircularProgressIndicator(backgroundColor: Colors.white)
            : Text(
                widget.text,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18.0),
                  color: Colors.white,
                ),
              ),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          // await Future.delayed(const Duration(seconds: 10));

          bool res = await widget.onPressed();
          if (res == false || res == true) {
            setState(() {
              isLoading = false;
            });
          }
        },
      ),
    );
  }
}
