import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/Cart.dart';
import 'package:shopApp1/providers/products_providers.dart';
import 'package:shopApp1/screens/Cart._Screen.dart';
import 'package:shopApp1/widgets/Drawer.dart';
import 'package:shopApp1/widgets/badge.dart';
import 'package:shopApp1/widgets/products_Gridveiw.dart';

enum filtersOptions { ShowAll, Favorites }

class productOverview extends StatefulWidget {
  @override
  _productOverviewState createState() => _productOverviewState();
}

class _productOverviewState extends State<productOverview> {
  var _showFavoritesOnly = false;
  bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<Products>(context, listen: false)
            .getProductsData()
            .then((value) {
          setState(() {
            _isLoading = false;
          });
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          //to filter if we should show all produvts or not
          PopupMenuButton(
              onSelected: (filtersOptions value) {
                if (value == filtersOptions.Favorites) {
                  setState(() {
                    _showFavoritesOnly = true;
                  });
                } else {
                  setState(() {
                    _showFavoritesOnly = false;
                  });
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Favorites'),
                      value: filtersOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('show All'),
                      value: filtersOptions.ShowAll,
                    ),
                  ]),
          Consumer<Cart>(
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
            builder: (_, cartObject, iconButtonchild) => Badge(
              child: iconButtonchild,
              //the value is the #of items in a cert
              value: cartObject.itemsCounter.toString(),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : products_gridveiw(
              toShowFavorites: _showFavoritesOnly,
            ),
    );
  }
}
