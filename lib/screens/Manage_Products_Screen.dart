import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/products_providers.dart';
import 'package:shopApp1/screens/Edit_Product_Screen.dart';
import 'package:shopApp1/widgets/Manage_Product_item.dart';
import 'package:shopApp1/widgets/Drawer.dart';

class ProductsScreen extends StatelessWidget {
  static String RouteName = 'ProductsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('your Products'),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.route);
                })
          ],
        ),
        drawer: AppDrawer(),
        body: Consumer<Products>(builder: (c, productobject, _) {
          return ListView.builder(
            itemCount: productobject.itemgetter.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ManageProductItem(
                    title: productobject.itemgetter[index].title,
                    imageUrl: productobject.itemgetter[index].imageUrl,
                    id: productobject.itemgetter[index].id,
                  ),
                  Divider(),
                ],
              );
            },
          );
        }));
  }
}
