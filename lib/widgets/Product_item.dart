import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/Cart.dart';
import 'package:shopApp1/providers/product.dart';
import 'package:shopApp1/screens/product_Details.dart';

class ProductItem extends StatelessWidget {
  // final String productid;
  // final String title;
  // final String imageurl;

  // const ProductItem(
  //     {Key key,
  //     @required this.productid,
  //     @required this.title,
  //     @required this.imageurl})
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productToShow = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    //here i`m interested in changes in product
    return Consumer<Product>(
        builder: (context, productToShow, child) => GridTile(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProductDetails.routeName,
                        arguments: productToShow.id);
                  },
                  child: Image.network(
                    productToShow.imageUrl,
                    fit: BoxFit.cover,
                    height: 400,
                  ),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  productToShow.title,
                  textAlign: TextAlign.center,
                ),
                leading: IconButton(
                    icon: Icon(productToShow.isfavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      productToShow.TriggerFavoriteStatus();
                    }),
                trailing: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      cart.addItem(productToShow.id, productToShow.title,
                          productToShow.price);
                      //  Scaffold.of(context).openDrawer();
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 4),
                          content: Text('item added successfully!'),
                          action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () =>
                                  cart.removeSingleItem(productToShow.id)),
                        ),
                      );
                    }),
              ),
            ));
  }
}
