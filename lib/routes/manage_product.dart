import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product_list_provider.dart';
import 'package:shopapp/routes/add_edit_product.dart';
import 'package:shopapp/widgets/maindrawer.dart';
import 'package:shopapp/widgets/manage_order_item_view.dart';

class ManageProduct extends StatelessWidget {
  static const String routeName = 'manageProduct';
  Future<void> refreshProd(BuildContext context) async {
    await Provider.of<ProductList>(context, listen: false).fetchProduct(false);
  }

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
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditProduct.routeName);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProd(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: FutureBuilder(
            future: Provider.of<ProductList>(context, listen: false)
                .fetchProduct(false),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('An Error Occured!!!'),
                  );
                } else {
                  return Consumer<ProductList>(builder: (ctx, proList, child) {
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        return ManageOrderItemView(proList.productlist[index]);
                      },
                      itemCount: proList.productlist.length,
                    );
                  });
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
