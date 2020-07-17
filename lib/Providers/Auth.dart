import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _idToken;

  String get idToken {
    return _idToken;
  }

  final _loginURL =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCaSwmSw38hKg9kVtqDbziz2wgvPh3UoVk';

  Future<void> login(String email, String password) async {
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    try {
      final response = await http.post(_loginURL, body: jsonEncode(body));
      final responseMap = jsonDecode(response.body);
      _idToken = responseMap['idToken'];
      print(_idToken);
      notifyListeners();
    } catch (error) {
      return Future.error(StateError('Illegal state'));
    }
  }
}
