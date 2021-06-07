import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shopapp/constants/consts.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFaourite = false;

  Product({
    @required this.id,
    @required this.description,
    @required this.imageUrl,
    this.isFaourite,
    @required this.price,
    @required this.title,
  });

  Future<void> setFav() async {
    Uri url = Uri.https(Constants.fireBaseUrl, '/product/$id.json');
    bool oldValue = isFaourite;
    isFaourite = !isFaourite;
    notifyListeners();
    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'isFav': isFaourite,
          },
        ),
      );
      if (response.statusCode >= 400) {
        isFaourite = oldValue;
        notifyListeners();
        throw Exception('Unable to Update Favourite Status');
      }
    } catch (error) {
      isFaourite = oldValue;
      notifyListeners();
      print('catch exception' + error);
    }
  }
}
