import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/products_providers.dart';
import 'package:shopApp1/screens/Edit_Product_Screen.dart';

class ManageProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  const ManageProductItem(
      {Key key,
      @required this.title,
      @required this.imageUrl,
      @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  //here i have to pass the product id to edit it
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.route, arguments: id);
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(' Deletion failed'),
                              content: Text(' an error accured '),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('ok'))
                              ],
                            ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
