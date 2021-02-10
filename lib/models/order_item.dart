import 'package:flutter/cupertino.dart';
import 'package:shopApp1/models/Cart_item.dart';

class OrderItem {
  final String orderId;
  final double totalPrice;
  final List<CartItem> items;
  final DateTime orderDate;

  OrderItem(
      {@required this.orderId,
      @required this.totalPrice,
      @required this.items,
      @required this.orderDate});
}
