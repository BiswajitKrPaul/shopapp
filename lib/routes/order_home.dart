import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/widgets/order_item_view.dart';

class OrderHome extends StatelessWidget {
  static const routeName = 'OrderHome';
  @override
  Widget build(BuildContext context) {
    final allOrders = Provider.of<Orders>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: allOrders.orders.length,
        itemBuilder: (ctx, index) {
          return OrderItemView(
            orderData: allOrders.orders[index],
            index: index,
          );
        },
      ),
    );
  }
}
