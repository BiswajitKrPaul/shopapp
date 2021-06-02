import 'package:flutter/material.dart';
import 'package:shopapp/routes/manage_product.dart';
import 'package:shopapp/routes/order_home.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text(
            'Shop App',
            style: TextStyle(
              color: Theme.of(context).primaryTextTheme.headline6.color,
              fontSize: 30,
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.shop,
          ),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.payment,
          ),
          title: Text('My Orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrderHome.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.edit,
          ),
          title: Text('Manage Orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(ManageProduct.routeName);
          },
        ),
      ],
    ));
  }
}
