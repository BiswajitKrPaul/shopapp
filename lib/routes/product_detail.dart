import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product_list_provider.dart';

class ProductDetail extends StatelessWidget {
  static const String routeName = '/productDetails';
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductList>(context, listen: false)
        .getProductFromId(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Hero(
                  tag: loadedProduct.id,
                  child: Image.network(
                    loadedProduct.imageUrl,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Text(
                '${loadedProduct.description}',
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
