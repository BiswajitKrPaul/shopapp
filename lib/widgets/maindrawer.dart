import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final Function drawercheck;
  MainDrawer(this.drawercheck);
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
          leading: Icon(Icons.shop),
          title: Text('Home'),
          onTap: () {
            drawercheck(false);
            Navigator.pop(context);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('My Orders'),
          onTap: () {
            drawercheck(true);
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}
