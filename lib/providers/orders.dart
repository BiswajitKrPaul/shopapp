import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:uuid/uuid.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime orderDateTime;

  OrderItem({this.id, this.amount, this.orderDateTime, this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  var uuid = Uuid();

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItem, double totalAmount) {
    _orders.add(
      OrderItem(
        id: uuid.v4(),
        amount: totalAmount,
        products: cartItem,
        orderDateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
