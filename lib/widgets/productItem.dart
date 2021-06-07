import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:toast/toast.dart';
import '../providers/cart.dart';

import 'package:shopapp/routes/product_detail.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        10,
      ),
      child: GridTile(
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetail.routeName,
              arguments: product.id,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, pro, child) => IconButton(
              icon:
                  Icon(pro.isFaourite ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                try {
                  await pro.setFav();
                } catch (error) {
                  Toast.show('Unable to Update Favourite Status', ctx,
                      duration: Toast.LENGTH_SHORT);
                }
              },
            ),
          ),
          trailing: Consumer<Cart>(
            builder: (ctx, cartItem, child) => IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                cartItem.addToCart(
                  product.id,
                  product.title,
                  product.price,
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added Sucessfully to Cart'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cartItem.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
