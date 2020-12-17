import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/screens/details/product_details.dart';
import 'package:e_commerce_app/services/database_service.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key key,
      this.width = 140.0,
      this.aspectRatio = 1.02,
      this.padding = 0.0,
      @required this.product})
      : super(key: key);
  final Product product;
  final double width, aspectRatio, padding;

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Container(
      width: getProportionateScreenWidth(width),
      height: getProportionateScreenHeight(300.0),
      padding: EdgeInsets.only(right: getProportionateScreenWidth(padding)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: aspectRatio,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProductDetails.routeName,
                  arguments: ProductDetailsArguments(product: product),
                );
              },
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(20.0),
                ),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.images[0],
                  placeholder: (BuildContext context, String url) =>
                      CircularProgressIndicator(),
                  errorWidget:
                      (BuildContext context, String url, dynamic error) => Icon(
                    Icons.error,
                  ),
                ),
                // child: Image.asset("assets/images/ps4_console_white_1.png"),
              ),
            ),
          ),
          Text(
            product.name,
            style: TextStyle(color: Colors.black),
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  NumberFormat.currency(name: 'Naira', symbol: 'NGN').format(
                    product.price,
                  ),
                  // "\$${product.price}",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(15.0),
                      fontWeight: FontWeight.w600),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  var productToDelete;
                  for (var item in cart.items) {
                    if (item.product.id == product.id) {
                      productToDelete = item;
                    }
                  }
                  !cart.isAdded(product)
                      ? cart.addToCart(
                          CartModel(
                            product: product,
                            qty: 1,
                          ),
                        )
                      : cart.removeFromCart(productToDelete);
                  // Provider.of<Cart>(context, listen: false).addToCart(
                  //   CartModel(product: product, qty: 1),
                  // );
                },
                child: Container(
                  width: getProportionateScreenWidth(28.0),
                  height: getProportionateScreenWidth(28.0),
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(8.0),
                  ),
                  decoration: BoxDecoration(
                    color: !cart.isAdded(product)
                        ? kSecondaryColor.withOpacity(0.15)
                        : kSecondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Cart Icon.svg",
                    color: !cart.isAdded(product) ? Colors.green : Colors.red,
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  bool isFav = !product.isFavourite;
                  product..isFavourite = isFav;

                  await DatabaseService().updateProduct(product);
                },
                child: Container(
                  width: getProportionateScreenWidth(28.0),
                  height: getProportionateScreenWidth(28.0),
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(8.0),
                  ),
                  decoration: BoxDecoration(
                    color: product.isFavourite
                        ? kSecondaryColor.withOpacity(0.15)
                        : kSecondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Heart Icon_2.svg",
                    color: product.isFavourite ? kPrimaryColor : null,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
