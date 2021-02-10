import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/Cart.dart' show Cart;
import 'package:shopApp1/providers/Orders.dart';
import '../widgets/Cart_Item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Total'),
                  Spacer(),
                  Chip(
                    padding: EdgeInsets.all(5),
                    label: Text(
                      '\$${cart.getTotal()}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                      onPressed: () async {
                        await Provider.of<Orders>(context, listen: false)
                            .addOrder(
                                cart.getitems.values.toList(), cart.getTotal());
                        cart.clear();
                      },
                      child: Text('ORDER NOW')),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, i) => CartItem(
              id: cart.getitems.values.toList()[i].id,
              title: cart.getitems.values.toList()[i].title,
              itemPrice: cart.getitems.values.toList()[i].price,
              quantity: cart.getitems.values.toList()[i].quantity,
              productId: cart.getitems.keys.toList()[i],
            ),
            itemCount: cart.itemsCounter,
          ))
        ],
      ),
    );
  }
}
