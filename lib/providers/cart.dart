import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Cart with ChangeNotifier {
  List<CartModel> items = [];

  double get total {
    return items.fold(0.0, (double currentTotal, CartModel nextProduct) {
      return currentTotal + nextProduct.product.price * nextProduct.qty;
    });
  }

  bool isAdded(Product item) {
    var contain = items.where((element) => element.product.id == item.id);
    if (contain.isEmpty)
      return false;
    else
      return true;
  }

  addToCart(CartModel item) {
    print("${isAdded(item.product)}");
    if (!isAdded(item.product)) {
      items.add(item);
      notifyListeners();
    } else
      print("Product is already in cart");
  }

  void removeFromCart(CartModel item) {
    items.remove(item);
    notifyListeners();
  }

  void increaseQty(int index) {
    items[index].qty++;
    notifyListeners();
  }

  void decreaseQty(index) {
    if (items[index].qty > 1) {
      items[index].qty--;
    }

    notifyListeners();
  }
}
