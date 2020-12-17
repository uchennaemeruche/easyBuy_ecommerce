import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final String icon;
  final Function onTap;
  final int notificationCount;

  const NotificationIcon(
      {Key key, this.icon, this.onTap, this.notificationCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        CustomSocialIcon(
          iconPath: icon,
          padding: 7.0,
          margin: 0,
          width: 46.0,
          height: 46.0,
          onTap: onTap,
        ),
        Positioned(
          top: -3,
          right: 2,
          child: Container(
            width: getProportionateScreenWidth(15.0),
            height: getProportionateScreenHeight(15.0),
            decoration: BoxDecoration(
              color: Color(0xFFFF4848),
              shape: BoxShape.circle,
              border: Border.all(width: 1.0, color: Colors.white),
            ),
            child: Text(
              notificationCount.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(10.0),
                height: 1.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
