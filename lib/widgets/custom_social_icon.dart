import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialIcon extends StatelessWidget {
  final String iconPath;

  const CustomSocialIcon({Key key, this.iconPath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(12.0)),
          margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(6)),
          height: getProportionateScreenHeight(40.0),
          width: getProportionateScreenWidth(40.0),
          decoration:
              BoxDecoration(color: Color(0xFFF5F6F9), shape: BoxShape.circle),
          child: SvgPicture.asset(
            iconPath
        ),
      ),
    );
  }
}
