import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/Orders.dart';
import 'package:shopApp1/widgets/Drawer.dart';
import 'package:shopApp1/widgets/Order_Item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'Orders_Screen';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItem(
          order: ordersData.orders[index],
        ),
        itemCount: ordersData.orders.length,
      ),
    );
  }
}
