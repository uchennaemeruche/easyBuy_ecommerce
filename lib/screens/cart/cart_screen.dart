import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/cart.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_social_icon.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  formatAmount(amount) {
    return NumberFormat.currency(name: 'Naira', symbol: 'NGN').format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (BuildContext context, Cart cart, Widget child) {
        print("Cart Total: ${cart.total}");
        return Scaffold(
          backgroundColor: Color(0xFFF5F6F9),
          appBar: AppBar(
            backgroundColor: Color(0xFFF5F6F9),
            leading: SizedBox(
              width: getProportionateScreenWidth(40.0),
              height: getProportionateScreenWidth(40.0),
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CART",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  " ${cart.items.length} item${cart.items.length > 1 ? 's' : ''}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w200,
                      fontSize: getProportionateScreenWidth(12.0)),
                )
              ],
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding:
                    EdgeInsets.only(right: getProportionateScreenWidth(20.0)),
                child: IconButton(
                  splashColor: Colors.white,
                  splashRadius: 1.0,
                  icon: Icon(
                    Icons.more_horiz,
                    size: getProportionateScreenWidth(40.0),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
          body: cart.items.length <= 0
              ? Center(child: Text("Your cart is empty"))
              : ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    CartModel item = cart.items[index];
                    return buildCartItemCard(item, index, context);
                  },
                ),
          bottomNavigationBar: Container(
            height: getProportionateScreenHeight(100.0),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -15),
                  blurRadius: 20.0,
                  color: Color(0xFFDADADA).withOpacity(0.3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Total price for ${cart.items.length} item${cart.items.length > 1 ? 's' : ''}",
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                    Text(
                      formatAmount(cart.total),
                      // "\$${cart.total.toStringAsFixed(2).toString()}",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(20.0)),
                    ),
                    // Text(total.toStringAsFixed(2).toString()),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                cart.items.length > 0
                    ? Expanded(
                        child: DefaultButton(
                          text: "Checkout",
                          onPressed: () {
                            return true;
                          },
                        ),
                      )
                    : Expanded(
                        child: DefaultButton(
                          text: "Continue Shopping",
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCartItemCard(CartModel cart, int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20.0),
        vertical: getProportionateScreenWidth(10.0),
      ),
      child: Dismissible(
        key: Key(cart.product.id.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<Cart>().removeFromCart(cart);
        },
        background: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFE6E6),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 5.0,
                color: Colors.red[200],
              )
            ],
          ),
          child: Row(
            children: [
              Spacer(),
              SvgPicture.asset("assets/icons/Trash.svg"),
              SizedBox(width: getProportionateScreenWidth(20.0)),
            ],
          ),
        ),
        child: Container(
          width: double.infinity,
          height: getProportionateScreenWidth(130.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 5.0,
                color: Colors.blue[200],
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                height: SizeConfig.screenWidth * 0.25,
                width: SizeConfig.screenWidth * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: cart.product.images[0],
                  placeholder: (BuildContext context, String url) =>
                      CircularProgressIndicator(),
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                          Icon(Icons.error),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: getProportionateScreenWidth(10.0),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          cart.product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: getProportionateScreenWidth(14.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      width: getProportionateScreenWidth(140.0),
                      child: TextFormField(
                        readOnly: true,
                        textInputAction: TextInputAction.none,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.zero,
                          hintText: cart.qty.toString(),
                          labelStyle: TextStyle(color: Colors.red),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          prefixIcon: InkWell(
                            onTap: () {
                              context.read<Cart>().decreaseQty(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(15.0)),
                              margin: EdgeInsets.only(
                                  right: getProportionateScreenWidth(15.0)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0))),
                              child:
                                  SvgPicture.asset("assets/icons/remove.svg"),
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              context.read<Cart>().increaseQty(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                getProportionateScreenWidth(15.0),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Plus Icon.svg",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(children: [
                      SizedBox(
                        width: getProportionateScreenWidth(90.0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            formatAmount(cart.product.price),
                            // "\$${cart.product.price}",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      SizedBox(
                        width: getProportionateScreenWidth(90),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            formatAmount(
                              (cart.product.price * cart.qty),
                            ),
                            // "\$${(cart.product.price * cart.qty).toStringAsFixed(2)}",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
