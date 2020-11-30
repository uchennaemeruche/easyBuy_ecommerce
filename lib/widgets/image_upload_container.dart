import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:flutter/material.dart';

class ImageUploadContainer extends StatelessWidget {
  const ImageUploadContainer(
      {Key key, this.onTap, this.caption, this.imageWidget})
      : super(key: key);

  final Function onTap;
  final String caption;
  final Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // onTap: () => getImage(ImageSource.camera),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 5.0,
              color: Colors.red[200],
            )
          ],
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          padding: EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 80,
              width: SizeConfig.screenWidth * 0.37,
              child: Column(
                children: [
                  Text(caption),
                  Expanded(
                    child: Image.asset(
                      "assets/images/upload.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
