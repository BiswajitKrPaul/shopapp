import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:toast/toast.dart';
import '../widgets/cart_item_view.dart';

class CartHome extends StatelessWidget {
  static const String routeName = 'CartHome';
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartItems.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cartItems: cartItems),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: CartItemView(cartItems: cartItems, index: index),
                );
              },
              itemCount: cartItems.items.length,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartItems,
  }) : super(key: key);

  final Cart cartItems;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: const CircularProgressIndicator(),
          )
        : TextButton(
            onPressed: widget.cartItems.totalAmount <= 0
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await Provider.of<Orders>(context, listen: false)
                          .addOrder(widget.cartItems.items.values.toList(),
                              widget.cartItems.totalAmount);
                      setState(() {
                        isLoading = false;
                      });
                      widget.cartItems.removeAllFromCart();
                    } catch (error) {
                      Toast.show('Unable to place the order', context);
                    }
                  },
            child: Text(
              'Order Now',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
  }
}
