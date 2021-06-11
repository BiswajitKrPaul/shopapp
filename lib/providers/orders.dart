import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shopapp/constants/consts.dart';
import 'package:shopapp/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime orderDateTime;

  OrderItem({this.id, this.amount, this.orderDateTime, this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String token;

  List<OrderItem> get orders {
    return [..._orders.reversed];
  }

  Future<void> fetchOrders() async {
    Uri url = Uri.parse(
        '${Constants.fireBaseUrl}${Constants.orderListNode}?auth=$token');
    final response = await http.get(url);
    List<OrderItem> temP = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData != null) {
      extractedData.forEach(
        (key, value) {
          temP.add(
            OrderItem(
              id: key,
              amount: value['amount'],
              orderDateTime: DateTime.parse(value['orderDateTime']),
              products: (value['products'] as List<dynamic>)
                  .map(
                    (e) => CartItem(
                        id: e['id'],
                        price: e['price'],
                        quantity: e['quantity'],
                        title: e['title']),
                  )
                  .toList(),
            ),
          );
        },
      );
      _orders = temP;
      notifyListeners();
    }
  }

  Future<void> addOrder(List<CartItem> cartItem, double totalAmount) async {
    var orderDate = DateTime.now();
    Uri url = Uri.parse(
        '${Constants.fireBaseUrl}${Constants.orderListNode}?auth=$token');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': totalAmount,
          'orderDateTime': orderDate.toIso8601String(),
          'products': cartItem
              .map(
                (e) => {
                  'id': e.id,
                  'price': e.price,
                  'quantity': e.quantity,
                  'title': e.title
                },
              )
              .toList()
        },
      ),
    );
    _orders.add(
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: totalAmount,
        products: cartItem,
        orderDateTime: orderDate,
      ),
    );
    notifyListeners();
  }
}
