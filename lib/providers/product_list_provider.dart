import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp/constants/consts.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _productList = [];

  List<Product> get productlist {
    return [..._productList];
  }

  List<Product> get favouriteProductList {
    return _productList.where((element) => element.isFaourite).toList();
  }

  Future<void> fetchProduct() async {
    Uri uri = Uri.https(Constants.fireBaseUrl, Constants.productListNode);
    try {
      final response = await http.get(uri);
      final extractedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      List<Product> tempP = [];
      extractedResponse.forEach((key, value) {
        tempP.add(
          Product(
              id: key,
              description: value['Description'],
              imageUrl: value['imageUrl'],
              price: value['Price'],
              title: value['Title'],
              isFaourite: value['isFav']),
        );
      });
      _productList = tempP;
      notifyListeners();
    } catch (error) {
      throw Exception('Error');
    }
  }

  Future<void> addProduct(Product newProduct) async {
    Uri url = Uri.https(Constants.fireBaseUrl, Constants.productListNode);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'Title': newProduct.title,
            'Price': newProduct.price,
            'Description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'isFav': false,
          },
        ),
      );
      Product tempP = Product(
        id: json.decode(response.body)['name'],
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        price: newProduct.price,
        title: newProduct.title,
        isFaourite: false,
      );
      _productList.add(tempP);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> removeProduct(Product newProduct) async {
    Uri url =
        Uri.https(Constants.fireBaseUrl, '/product/${newProduct.id}.json');
    final respose = await http.delete(url);
    if (respose.statusCode >= 400) {
      throw Exception('Deletion Failed');
    } else {
      _productList.remove(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product newProduct) async {
    int index = _productList.indexOf(
        _productList.firstWhere((element) => newProduct.id == element.id));
    if (index >= 0) {
      Uri url =
          Uri.https(Constants.fireBaseUrl, '/product/${newProduct.id}.json');
      await http.patch(
        url,
        body: json.encode(
          {
            'Title': newProduct.title,
            'Price': newProduct.price,
            'Description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
          },
        ),
      );
      _productList[index] = newProduct;
      notifyListeners();
    }
  }

  Product getProductFromId(String id) {
    return _productList.firstWhere((element) => element.id == id);
  }
}
