import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/product/components/add_edit_product.dart';
import 'package:e_commerce_app/services/database_service.dart';
import 'package:e_commerce_app/services/form_field_validation.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/category_choice_builder.dart';
import 'package:e_commerce_app/widgets/custom_textbox.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

adminProductList(context) {
  return showCupertinoModalBottomSheet(
    expand: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => AdminProductList(),
  );
}

class AdminProductList extends StatefulWidget {
  const AdminProductList({Key key}) : super(key: key);

  @override
  _AdminProductListState createState() => _AdminProductListState();
}

class _AdminProductListState extends State<AdminProductList> {
  DatabaseService _dbService = DatabaseService();
  final List<String> errors = [];
  String name, description;
  double rating, price;
  bool isFavourite = false, isPopular = false;

  String addError(String error) {
    print("NEw Error: $error");
    setState(() {
      errors.add(error);
    });
    return error;
  }

  String removeError(error) {
    setState(() {
      errors.remove(error);
    });
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
        value: _dbService.products,
        catchError: (BuildContext context, Object obj) {
          print(
              "Hello, an error occurred  Admin Product Listing page in the category stream builder: $obj");
          return obj;
        },
        builder: (context, snapshot) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Material(
              color: Colors.transparent,
              child: Scaffold(
                backgroundColor: CupertinoTheme.of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(0.95),
                extendBodyBehindAppBar: true,
                appBar: appBar(context),
                body: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Builder(
                      builder: (BuildContext context) {
                        List<Product> products =
                            Provider.of<List<Product>>(context);
                        return products != null
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ...List.generate(
                                      products.length,
                                      (index) => buildProductListCard(
                                        products[index],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildProductListCard(Product product) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 1.0,
            color: Colors.blue[200],
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: product.images[0],
                placeholder: (BuildContext context, String url) =>
                    CircularProgressIndicator(),
                errorWidget:
                    (BuildContext context, String url, dynamic error) =>
                        Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenWidth(10.0),
                  ),
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: getProportionateScreenWidth(14.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenWidth(4.0),
                  ),
                  child: Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(11.0),
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "\$${product.price}",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pop();
                    addEditProduct(
                      context: context,
                      product: product,
                      isEditing: true,
                    );
                  },
                  child: Container(
                    width: getProportionateScreenWidth(28.0),
                    height: getProportionateScreenWidth(28.0),
                    padding: EdgeInsets.all(getProportionateScreenWidth(3.0)),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: kSecondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                InkWell(
                  onTap: () async {
                    await _dbService.deleteProduct(product.id);
                  },
                  child: Container(
                    width: getProportionateScreenWidth(28.0),
                    height: getProportionateScreenWidth(28.0),
                    padding: EdgeInsets.all(getProportionateScreenWidth(3.0)),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 104),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: CupertinoTheme.of(context)
                .scaffoldBackgroundColor
                .withOpacity(0.8),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 18),
                      CircleAvatar(
                        child: Icon(Icons.list),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Product List',
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 14),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                    ],
                  ),
                ),
                Divider(height: 1),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
