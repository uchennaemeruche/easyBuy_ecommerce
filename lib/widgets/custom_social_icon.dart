import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialIcon extends StatelessWidget {
  final String iconPath;
  final Function onTap;
  final double padding, width, height, margin;
  final Color color;

  CustomSocialIcon({Key key, this.iconPath, this.onTap, this.padding=12, this.width=46, this.height=46, this.margin=6.0, this.color = const Color(0xFFF5F6F9)   })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(padding)),
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(margin)),
        height: getProportionateScreenHeight(height),
        width: getProportionateScreenWidth(width),
        decoration:
            BoxDecoration(color: color, shape: BoxShape.circle),
        child: SvgPicture.asset(
          iconPath,
        ),
      ),
    );
  }
}
