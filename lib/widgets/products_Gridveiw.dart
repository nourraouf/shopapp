import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/products_providers.dart';
import 'package:shopApp1/widgets/Product_item.dart';

class products_gridveiw extends StatelessWidget {
  final bool toShowFavorites;

  const products_gridveiw({@required this.toShowFavorites});
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final productsitems = toShowFavorites
        ? productData.showFavoritesOnly()
        : productData.itemgetter;
    return GridView.builder(
      itemCount: productsitems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: productsitems[i],
        child: ProductItem(
            // productid: productsitems[i].id,
            // title: productsitems[i].title,
            // imageurl: productsitems[i].imageUrl,
            ),
      ),
    );
  }
}
