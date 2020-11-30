import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  List<CartModel> items = [];

  double get total {
    return items.fold(0.0, (double currentTotal, CartModel nextProduct) {
      return currentTotal + nextProduct.product.price * nextProduct.qty;
    });
  }

  void addToCart(CartModel item) {
    items.add(item);
    notifyListeners();
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
    items[index].qty--;
    notifyListeners();
  }
}
