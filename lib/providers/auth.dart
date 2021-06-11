import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp/constants/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/http_exceptions.dart';

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
      if (response.statusCode >= 400) {
        throw HttpException(json.decode(response.body)['error']['message']);
      } else {
        final extractedData = json.decode(response.body);
        _token = extractedData['idToken'];
        _expireTokenDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              extractedData['expiresIn'],
            ),
          ),
        );
        _userID = extractedData['localId'];
        notifyListeners();
      }
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
        throw HttpException(json.decode(response.body)['error']['message']);
      } else {
        final extractedData = json.decode(response.body);
        _token = extractedData['idToken'];
        _expireTokenDate = DateTime.now().add(
          Duration(
            seconds: int.parse(
              extractedData['expiresIn'],
            ),
          ),
        );
        _userID = extractedData['localId'];
      }
    } catch (error) {
      throw error;
    }
  }

  bool get isAuth {
    return token != null;
  }

  String get user {
    return _userID;
  }

  String get token {
    if (_expireTokenDate != null &&
        _token != null &&
        _expireTokenDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }
}
