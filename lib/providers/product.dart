import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String title;
  final String id;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavorite;

  Product(
      {@required this.imageUrl,
      @required this.title,
      @required this.id,
      @required this.description,
      @required this.price,
      this.isfavorite = false});
  Future<void> TriggerFavoriteStatus() async {
    final oldstatus = isfavorite;
    final url =
        'https://onlineshopping-51b2a-default-rtdb.firebaseio.com/products/$id';
    //make the update
    isfavorite = !isfavorite;
    notifyListeners();
    //make the request
    try {
      final response = await http.patch(
        url,
        body: json.encode({'isfavorite': isfavorite}),
      );
      if (response.statusCode >= 400) {
        isfavorite = oldstatus;
        notifyListeners();
      }
    } catch (error) {
      print(error);
      isfavorite = oldstatus;
      notifyListeners();
      // throw error;

    }
  }
}
