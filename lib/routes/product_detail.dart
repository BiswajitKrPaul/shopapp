import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  static const String routeName = '/productDetails';
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
      body: Container(),
    );
  }
}
