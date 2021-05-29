import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_list_provider.dart';
import './productItem.dart';

class GridItemBuilder extends StatelessWidget {
  final bool isFavCheck;
  GridItemBuilder(this.isFavCheck);
  @override
  Widget build(BuildContext context) {
    final productListObj = Provider.of<ProductList>(context); // provider object
    final productList = isFavCheck
        ? productListObj.favouriteProductList
        : productListObj.productlist;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: productList[index],
        child: ProductItem(),
      ),
      itemCount: productList.length,
    );
  }
}
