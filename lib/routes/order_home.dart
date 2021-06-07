import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/widgets/maindrawer.dart';
import 'package:shopapp/widgets/order_item_view.dart';

class OrderHome extends StatelessWidget {
  static const routeName = 'OrderHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('An Error Occured!!!'),
              );
            } else {
              return Consumer<Orders>(builder: (ctx, allOrders, child) {
                return ListView.builder(
                  itemCount: allOrders.orders.length,
                  itemBuilder: (ctx, index) {
                    return OrderItemView(
                      orderData: allOrders.orders[index],
                      index: index,
                    );
                  },
                );
              });
            }
          }
        },
      ),
    );
  }
}
