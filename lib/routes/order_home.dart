import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/widgets/maindrawer.dart';
import 'package:shopapp/widgets/order_item_view.dart';

class OrderHome extends StatefulWidget {
  static const routeName = 'OrderHome';

  @override
  _OrderHomeState createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  bool isLoading = false;
  bool isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Orders>(context).fetchOrders().then((_) {
        setState(() {
          isLoading = false;
        });
      });
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allOrders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: MainDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
