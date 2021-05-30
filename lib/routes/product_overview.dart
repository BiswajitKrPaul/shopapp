import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/routes/cart_home.dart';
import 'package:shopapp/routes/order_home.dart';
import 'package:shopapp/widgets/maindrawer.dart';

import '../widgets/grid_item_builder.dart';

enum FilteredOptions {
  Favourites,
  All,
}

class ProductOverview extends StatefulWidget {
  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool isFavCheck = false;
  bool drawerCheck = false;

  void setDrawer(bool value) {
    setState(() {
      drawerCheck = value;
    });
  }

  Widget myHome(bool isFav) {
    return GridItemBuilder(isFav);
  }

  Widget myOrder() {
    return OrderHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(setDrawer),
      appBar: AppBar(
        title: drawerCheck ? Text('My Orders') : Text('Shop App'),
        actions: drawerCheck
            ? []
            : [
                Consumer<Cart>(
                  builder: (ctx, cart, child) => Badge(
                    badgeColor: Theme.of(context).accentColor,
                    position: BadgePosition.topEnd(top: 0),
                    badgeContent: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(cart.totalQuantity.toString()),
                    ),
                    animationType: BadgeAnimationType.fade,
                    showBadge: cart.totalQuantity == 0 ? false : true,
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          CartHome.routeName,
                        );
                      },
                    ),
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  onSelected: (FilteredOptions selected) {
                    setState(() {
                      if (selected == FilteredOptions.Favourites) {
                        isFavCheck = true;
                      } else {
                        isFavCheck = false;
                      }
                    });
                  },
                  itemBuilder: (ctx) => [
                    PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: FilteredOptions.Favourites,
                    ),
                    PopupMenuItem(
                      child: Text('All Product'),
                      value: FilteredOptions.All,
                    )
                  ],
                )
              ],
      ),
      body: drawerCheck ? myOrder() : myHome(isFavCheck),
    );
  }
}
