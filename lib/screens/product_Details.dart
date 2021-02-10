import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/products_providers.dart';

class ProductDetails extends StatelessWidget {
  // final String title;

  // const ProductDetails({Key key, this.title}) : super(key: key);
  static const String routeName = '/ProductDetails';

  @override
  Widget build(BuildContext context) {
    final String selectedid =
        ModalRoute.of(context).settings.arguments as String;
    final loadedproduct = Provider.of<Products>(context).findById(selectedid);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedproduct.title),
      ),
    );
  }
}
