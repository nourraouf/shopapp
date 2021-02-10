import 'package:flutter/foundation.dart';
import 'package:shopApp1/models/Cart_item.dart';

//cart item contains some information about each product

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {}; //the string key is the product id

  Map<String, CartItem> get getitems {
    return {..._items};
  }

  double getTotal() {
    double _totalPrice = 0;
    _items.forEach((key, items) {
      _totalPrice += items.price * items.quantity;
    });
    return _totalPrice;
  }

  int get itemsCounter {
    return _items.length;
  }

  void addItem(String productid, String title, double price) {
    if (_items.containsKey(productid)) {
      _items.update(
        productid,
        (value) =>
            CartItem(value.title, value.id, value.quantity + 1, value.price),
      );
    } else {
      _items.putIfAbsent(productid,
          () => CartItem(title, DateTime.now().toString(), 1, price));
    }
    notifyListeners();
  }

  void removeItem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void removeSingleItem(String productid) {
    if (!_items.containsKey(productid))
      return; //the approach is used to cancel the function excution
    else if (_items[productid].quantity > 1) {
      _items.update(
          productid,
          (value) =>
              CartItem(value.title, value.id, value.quantity - 1, value.price));
    } else {
      _items.remove(productid);
    }
    notifyListeners();
  }

  //after placing an order we should clear the cart because we ordered all items
  void clear() {
    _items = {};
  }
}
