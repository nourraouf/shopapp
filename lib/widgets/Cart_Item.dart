import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/Cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double itemPrice;

  final String productId;
  // final double totalprice;

  const CartItem({
    Key key,
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.itemPrice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Are You sure?',
                style: TextStyle(color: Colors.black),
              ),
              content: Text('Do you want to remove the Item form the cart?'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('Cancel')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Ok'))
              ],
            );
          },
        );
      },
      key: ValueKey(id),
      //to specify which direction should the dismiss be
      // direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Colors.red[300],
        child: ListTile(
          leading: Text('Remove', style: Theme.of(context).textTheme.title),
          trailing: Icon(
            Icons.delete,
            color: Colors.white54,
          ),
        ),
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Image.network(
                'data:image/jpeg;base64,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'),
          ),
          title: Text(title),
          subtitle: Text('\$$itemPrice'),
          trailing: Column(
            children: <Widget>[
              Text('$quantity' + 'x'),
              Text('Total:' + '${(itemPrice * quantity)}')
            ],
          ),
        ),
      ),
    );
  }
}
