import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/Cart.dart';
import 'package:shopApp1/providers/Orders.dart';
import 'package:shopApp1/providers/products_providers.dart';
import 'package:shopApp1/screens/Cart._Screen.dart';
import 'package:shopApp1/screens/Edit_Product_Screen.dart';
import 'package:shopApp1/screens/Manage_Products_Screen.dart';
import 'package:shopApp1/screens/Orders_Screen.dart';
import 'package:shopApp1/screens/product_Details.dart';
import 'package:shopApp1/screens/product_overview_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(create: (context) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.orange,
            fontFamily: 'Lato',
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
        home: productOverview(),
        routes: {
          ProductDetails.routeName: (context) => ProductDetails(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          ProductsScreen.RouteName: (context) => ProductsScreen(),
          EditProductScreen.route: (context) => EditProductScreen(),
        },
      ),
    );

    //all child widgets of the class including the material app can listen to this class
  }
}
