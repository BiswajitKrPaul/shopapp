import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.favorite_outline),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: Icon(Icons.shop_outlined),
          onPressed: () {},
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          product.price.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
