import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  static String routeName = "/details";
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedImage = 0;
  int selectedColor = 4;
  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments args =
        ModalRoute.of(context).settings.arguments;
    final Product product = args.product;
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: CustomAppBar(rating: product.rating),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(238.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: product.images[selectedImage],
                        placeholder: (BuildContext context, String url) =>
                            CircularProgressIndicator(),
                        errorWidget:
                            (BuildContext context, String url, dynamic error) =>
                                Icon(Icons.error),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                              Colors.white.withOpacity(0.3),
                              (product.colors[selectedColor]).withOpacity(0.3)
                            ])),
                      )
                    ],
                  ),
                ),
              ),
              buildImageListCard(product),
              buildRoundedContainer(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProductDetails(product, context),
                    buildRoundedContainer(
                      color: Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          buildProductColorRows(product),
                          buildRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.15,
                                  right: SizeConfig.screenWidth * 0.15,
                                  bottom: getProportionateScreenWidth(15.0),
                                  top: getProportionateScreenWidth(15.0)),
                              child: DefaultButton(
                                text: "Add to Cart",
                                onPressed: () {
                                  print("Added to cart");
                                  Provider.of<Cart>(context, listen: false)
                                      .addToCart(
                                          CartModel(product: product, qty: 1));
                                  return true;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget buildColorDot(Color color, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(2.0)),
        padding: EdgeInsets.all(getProportionateScreenWidth(8.0)),
        width: getProportionateScreenWidth(40.0),
        height: getProportionateScreenWidth(40.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: selectedColor == index
                    ? kPrimaryColor
                    : Color(0xFFF6F7F9))),
        child: DecoratedBox(
            decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        )),
      ),
    );
  }

  Padding buildProductColorRows(Product product) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20.0),
        vertical: getProportionateScreenWidth(10.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(
              product.colors.length,
              (index) => buildColorDot(product.colors[index], index),
            ),
            SizedBox(width: getProportionateScreenWidth(40.0)),
            CustomSocialIcon(
              iconPath: "assets/icons/remove.svg",
              color: Colors.white,
              padding: 15.0,
              margin: 0,
              width: 46.0,
              height: 46.0,
              onTap: () {
                print("Cart");
              },
            ),
            CustomSocialIcon(
              iconPath: "assets/icons/Plus Icon.svg",
              color: Colors.white,
              padding: 10.0,
              margin: 0,
              width: 46.0,
              height: 46.0,
              onTap: () {
                print("Cart");
              },
            ),
          ],
        ),
      ),
    );
  }

  Row buildImageListCard(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            product.images.length,
            (index) => _buildImagePreview(
                  product.images[index],
                  index,
                ))
      ],
    );
  }

  Column buildProductDetails(Product product, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0)),
          child:
              Text(product.name, style: Theme.of(context).textTheme.headline6),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15.0)),
            width: getProportionateScreenWidth(64.0),
            decoration: BoxDecoration(
              color:
                  product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            child: SvgPicture.asset("assets/icons/Heart Icon_2.svg",
                color: product.isFavourite ? kPrimaryColor : null),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20.0),
            right: getProportionateScreenWidth(70.0),
          ),
          child: Text(
            product.description,
            maxLines: 4,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0),
              vertical: getProportionateScreenWidth(10.0)),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: getProportionateScreenWidth(4.0)),
                Icon(
                  Icons.arrow_forward_ios,
                  color: kPrimaryColor,
                  size: 14.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container buildRoundedContainer({Color color, Widget child}) {
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenWidth(20.0)),
      padding: EdgeInsets.only(top: getProportionateScreenWidth(20.0)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: child,
    );
  }

  Widget _buildImagePreview(String image, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15.0)),
        height: getProportionateScreenWidth(48.0),
        width: getProportionateScreenWidth(48.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
              color:
                  selectedImage == index ? kPrimaryColor : Colors.transparent),
        ),
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (BuildContext context, String url) =>
              CircularProgressIndicator(),
          errorWidget: (BuildContext context, String url, dynamic error) =>
              Icon(Icons.error),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  ProductDetailsArguments({@required this.product});
}
