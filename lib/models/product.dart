import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFaourite;

  Product({
    @required this.id,
    @required this.description,
    @required this.imageUrl,
    this.isFaourite,
    @required this.price,
    @required this.title,
  });
}
