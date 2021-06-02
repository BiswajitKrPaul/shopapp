import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';

class ManageOrderItemView extends StatelessWidget {
  final Product _product;
  ManageOrderItemView(this._product);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              _product.imageUrl,
            ),
          ),
          title: Text(
            _product.title,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
