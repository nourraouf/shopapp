import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shopApp1/models/exceptions.dart';
import 'package:shopApp1/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get itemgetter {
    return [..._items]; //sending a copy of this list
  }

  List<Product> showFavoritesOnly() {
    return _items.where((element) => element.isfavorite).toList();
  }

  Future<void> addproduct(Product newproduct) async {
    final url =
        'https://onlineshopping-51b2a-default-rtdb.firebaseio.com/products.json';
    //an http request returns a future and then also returns a future
    //so what will happen ?once the request is done then returns a future which will also will be returned by the function
    try {
      var value = await http.post(url,
          body: json.encode({
            'title': newproduct.title,
            'description': newproduct.description,
            'price': newproduct.price,
            'isfavorite': newproduct.isfavorite,
            'imageUrl': newproduct.imageUrl
          }));

      // print(json.decode(value.body));
      newproduct = Product(
          imageUrl: newproduct.imageUrl,
          title: newproduct.title,
          id: json.decode(value.body)['name'],
          description: newproduct.description,
          price: newproduct.price);
      _items.add(newproduct);

      notifyListeners();
    } catch (onError) {
      print(onError);
      throw onError;
    }
  }

  Product findById(String selectedid) {
    return _items.firstWhere((element) => element.id == selectedid);
  }

  Future<void> updateproduct(String id, Product updatedproduct) async {
    final url =
        'https://onlineshopping-51b2a-default-rtdb.firebaseio.com/products/$id.json';
    try {
      await http.patch(url,
          body: json.encode({
            'title': updatedproduct.title,
            'description': updatedproduct.description,
            'price': updatedproduct.price,
            'isfavorite': updatedproduct.isfavorite,
            'imageUrl': updatedproduct.imageUrl
          }));

      int index = _items.indexWhere((element) => element.id == id);
      index >= 0 ? _items[index] = updatedproduct : print('...');
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteProduct(String productId) async {
    final url =
        'https://onlineshopping-51b2a-default-rtdb.firebaseio.com/products/$productId';
    final productIndexCopy =
        _items.indexWhere((element) => element.id == productId);
    var productCopy = _items[productIndexCopy];

    await http.delete(url).then((value) {
      if (value.statusCode >= 400) {
        print(value.statusCode);
        throw httpExceptions('an error accured');
      }
      //_items.removeAt(productIndexCopy);
      // notifyListeners();
    }).catchError((onError) {
      print('hereeeeeeeeeeeeeeeeeeee');
      _items.insert(productIndexCopy, productCopy);
      notifyListeners();
    });
    _items.removeAt(productIndexCopy);
    print('************************************************');
    notifyListeners();
  }

  Future<Void> getProductsData() async {
    final url =
        'https://onlineshopping-51b2a-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      //  print(extractedData);
      final List<Product> loadedData = [];

      extractedData.forEach((productId, productData) {
        //  print(productData);
        Product p = new Product(
            imageUrl: productData['imageUrl'],
            title: productData['title'],
            id: productId,
            description: productData['description'],
            price: productData['price'],
            isfavorite: productData['isfavorite']);
        loadedData.add(p);
      });

      _items = loadedData;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
