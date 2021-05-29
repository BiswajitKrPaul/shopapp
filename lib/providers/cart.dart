import 'dart:collection';

import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get totalQuantity {
    int total = 0;
    _items.forEach((key, value) {
      total = total + value.quantity;
    });
    return total;
  }

  void addToCart(String productid, String productTitle, double productPrice) {
    if (_items.containsKey(productid)) {
      _items.update(
        productid,
        (value) => CartItem(
          // value here is the old existing data in the map.
          id: value.id,
          price: value.price,
          quantity: value.quantity + 1,
          title: value.title,
        ),
      );
    } else {
      _items.putIfAbsent(
        productid,
        () => CartItem(
          id: productid,
          price: productPrice,
          quantity: 1,
          title: productTitle,
        ),
      );
    }
    notifyListeners();
  }
}
