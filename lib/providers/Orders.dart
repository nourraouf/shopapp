import 'package:flutter/cupertino.dart';
import 'package:shopApp1/models/Cart_item.dart';
import 'package:shopApp1/models/order_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> orderitems, double totalPrice) async {
    final url =
        'https://onlineshopping-51b2a-default-rtdb.firebaseio.com/orders.json';
    var now = DateTime.now();
    try {
      var response = await http.post(url,
          body: json.encode({
            'totalPrice': totalPrice,
            'items': orderitems
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price
                    })
                .toList(),
            'orderDate': now.toIso8601String(),
          }));
      _orders.insert(
          0,
          OrderItem(
              orderId: json.decode(response.body)['name'],
              totalPrice: totalPrice,
              items: orderitems,
              orderDate: now));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
