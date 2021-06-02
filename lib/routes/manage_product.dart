import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product_list_provider.dart';
import 'package:shopapp/widgets/maindrawer.dart';
import 'package:shopapp/widgets/manage_order_item_view.dart';

class ManageProduct extends StatelessWidget {
  static const String routeName = 'manageProduct';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Order',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<ProductList>(builder: (ctx, proList, child) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return ManageOrderItemView(proList.productlist[index]);
            },
            itemCount: proList.productlist.length,
          );
        }),
      ),
    );
  }
}
