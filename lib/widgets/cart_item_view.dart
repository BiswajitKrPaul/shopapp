import 'package:flutter/material.dart';
import '../providers/cart.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({
    Key key,
    @required this.cartItems,
    @required this.index,
  }) : super(key: key);

  final Cart cartItems;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItems.items.values.toList()[index].id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(
                    'Are you sure?',
                    style: TextStyle(color: Colors.black),
                  ),
                  content: Text('You want to remove this item from cart.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ));
      },
      onDismissed: (direction) {
        cartItems.removeFromCart(cartItems.items.keys.toList()[index]);
      },
      direction: DismissDirection.endToStart,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
              child: Text(
                '\$${cartItems.items.values.toList()[index].price}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text('${cartItems.items.values.toList()[index].title}'),
        subtitle: Text(
          'Total : \$${(cartItems.items.values.toList()[index].quantity * cartItems.items.values.toList()[index].price)}',
        ),
        trailing: Text('x ${cartItems.items.values.toList()[index].quantity}'),
      ),
    );
  }
}
