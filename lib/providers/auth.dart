import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/constants/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/http_exceptions.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expireTokenDate;
  String _userID;
  Timer _authTimer;

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
        autoLogout();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'expireDt': _expireTokenDate.toIso8601String(),
          'userId': _userID
        });
        prefs.setString('userData', userData);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiredDate = DateTime.parse(extractedData['expireDt']);
    if (expiredDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'];
    _userID = extractedData['userId'];
    _expireTokenDate = expiredDate;
    print(_expireTokenDate);
    notifyListeners();
    autoLogout();
    return true;
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

  Future<void> logout() async {
    _expireTokenDate = null;
    _token = null;
    _userID = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpire = _expireTokenDate.difference(DateTime.now()).inSeconds;
    print(timeToExpire);
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }
}
