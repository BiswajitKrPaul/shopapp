import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        actions: [
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
                onPressed: () {},
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
      body: GridItemBuilder(isFavCheck),
    );
  }
}
