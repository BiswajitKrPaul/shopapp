import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp/constants/consts.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expireTokenDate;
  String _userID;

  Future<void> logIn(String email, String password) async {
    Uri uri = Uri.parse(Constants.authLogInUrl);
    try {
      final response = await http.post(
        uri,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    Uri url = Uri.parse(Constants.authUrl);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      if (response.statusCode >= 400) {
        throw Exception('Issue while SignUp');
      } else {
        final extractedData = json.decode(response.body);

        _token = extractedData['idToken'];
        _expireTokenDate = extractedData['expiresIn'];
        _userID = extractedData['localId'];
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
