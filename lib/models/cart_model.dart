import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class CartModel {
  final Product product;
  int qty;

  CartModel({@required this.product, this.qty = 1});
}

List<CartModel> cartItems = [
  CartModel(product: myProducts[0], qty: 1),
  CartModel(product: myProducts[1], qty: 3),
  CartModel(product: myProducts[2], qty: 2),
  CartModel(product: myProducts[3], qty: 5),
];
