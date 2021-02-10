import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp1/providers/product.dart';
import 'package:shopApp1/providers/products_providers.dart';

class EditProductScreen extends StatefulWidget {
  static String route = '/Productedit';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _initstate = true;
  final _imageUrl = TextEditingController();
  final _editFormKey = GlobalKey<FormState>();
  var _editedProduct =
      Product(description: '', id: null, imageUrl: '', price: 0, title: '');
  //to know when we should show loading indicator
  var _isloading = false;

  //map to use it for the hint texts in the fields
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': ''
  };
  Future<void> _submit() async {
    if (_editFormKey.currentState.validate()) {
      _editFormKey.currentState.save();
      setState(() {
        _isloading = true;
      });
      //we wanna check if i`m adding a new product of editing an existing one
      if (_editedProduct.id != null) {
//edit product with an id=editedproduct.id
        try {
          await Provider.of<Products>(context, listen: false)
              .updateproduct(_editedProduct.id, _editedProduct);
        } catch (error) {
          print('errorrrrrrrrrrrrrrrrrrrr');
          await showDialog(
              context: context,
              builder: (cont) => AlertDialog(
                    content: Text('an error accoured'),
                    title: Text('Error'),
                    actions: [
                      FlatButton(
                        child: Text('ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
        }
      } else {
        //add a new product
        try {
          await Provider.of<Products>(context, listen: false)
              .addproduct(_editedProduct);
        } catch (error) {
          print('errorrrrrrrrrrrrrrrrrrrr');
          await showDialog(
              context: context,
              builder: (cont) => AlertDialog(
                    content: Text('an error accoured'),
                    title: Text('Error'),
                    actions: [
                      FlatButton(
                        child: Text('ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
        }

        // } finally {
        //   setState(() {
        //     _isloading = false;
        //     Navigator.of(context).pop();
        //     print('finallyyyyyyyyyyyyyyyyy');
        //   });
        // }

      }
      setState(() {
        _isloading = false;
      });
      Navigator.of(context).pop();
    } else
      return;
  }

  @override
  void didChangeDependencies() {
    if (_initstate) {
      final productidToEdit =
          ModalRoute.of(context).settings.arguments as String;
      //search for this product in the product list
      if (productidToEdit != null) {
        _editedProduct =
            Provider.of<Products>(context).findById(productidToEdit);
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': ''
        };
        _imageUrl.text = _editedProduct.imageUrl.toString();
      }
    }
    _initstate = false;
    super.didChangeDependencies();
  }

  Future<Void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context).getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submit,
          )
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                _refresh(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _editFormKey,
                  child: ListView(
                    children: <Widget>[
                      //title
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(
                          labelText: "title",
                        ),
                        textInputAction: TextInputAction.next,
                        onSaved: (newValue) {
                          _editedProduct = Product(
                              imageUrl: _editedProduct.imageUrl,
                              title: newValue,
                              id: _editedProduct.id,
                              isfavorite: _editedProduct.isfavorite,
                              description: _editedProduct.description,
                              price: _editedProduct.price);
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return 'please enter a valid title';
                          return null;
                        },
                      ),
                      //priceeeeeeee
                      TextFormField(
                        initialValue: _initValues['price'].toString(),
                        decoration: InputDecoration(
                          labelText: "price",
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSaved: (newValue) {
                          _editedProduct = Product(
                              isfavorite: _editedProduct.isfavorite,
                              imageUrl: _editedProduct.imageUrl,
                              title: _editedProduct.title,
                              id: _editedProduct.id,
                              description: _editedProduct.description,
                              price: double.parse(newValue));
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return 'please enter a number';
                          else if (double.tryParse(value) == null)
                            return 'please enter a valid number';
                          else if (double.parse(value) <= 0)
                            return 'please enter a valid price';
                          return null;
                        },
                      ),
                      //discripppppppppppp
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                        maxLines: 3,
                        onSaved: (newValue) {
                          _editedProduct = Product(
                              imageUrl: _editedProduct.imageUrl,
                              title: _editedProduct.title,
                              id: _editedProduct.id,
                              description: newValue,
                              price: _editedProduct.price);
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return 'please enter a valid Description';
                          return null;
                        },
                      ),
                      //imageeeeeeeeeee
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: _imageUrl.text.isEmpty
                                  ? Container(
                                      child: Text('enter image url'),
                                    )
                                  : Container(
                                      child: FittedBox(
                                        child: Image.network(
                                          _imageUrl.text,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "ImageUrl",
                                ),
                                textInputAction: TextInputAction.done,
                                controller: _imageUrl,
                                //  onSaved: (newValue) => print(_imageUrl.text),
                                onFieldSubmitted: (value) {
                                  _submit();
                                },
                                onSaved: (newValue) {
                                  _editedProduct = Product(
                                      imageUrl: newValue,
                                      title: _editedProduct.title,
                                      id: _editedProduct.id,
                                      description: _editedProduct.description,
                                      price: _editedProduct.price);
                                },
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'please enter a valid url';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
