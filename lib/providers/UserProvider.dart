import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fruit_salad/user.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class UserProvider extends ChangeNotifier {
  late User? _user;
  late bool _isConnected = false;
  late bool _showRegisterForm = false;

  Future<void> signinUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://fruits.shrp.dev/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 401) {
      throw Exception('Failed to login user');
    }

    var body = jsonDecode(response.body);

    Map<String, dynamic> userProfile =
        Jwt.parseJwt(body['data']['access_token']);

    final User user = User.fromJson({
      'id': userProfile['id'],
      'email': email,
      'role': userProfile['role'],
      'app_access': userProfile['app_access'],
      'admin_access': userProfile['admin_access'],
      'token': body['data'],
    });

    setCurrentUser(user);
    notifyListeners();
  }

  Future<void> registerUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://fruits.shrp.dev/users'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'role': 'ca2c1507-d542-4f47-bb63-a9c44a536498',
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to register user');
    }
  }

  User? get currentUser => _user;

  bool get isConnected => _isConnected;

  bool get showRegisterForm => _showRegisterForm;

  void setShowRegisterForm(bool state) {
    _showRegisterForm = state;
    notifyListeners();
  }

  void setConnectedState(bool state) {
    _isConnected = state;
    notifyListeners();
  }

  void setCurrentUser(User? u) {
    _user = u;
    notifyListeners();
  }
}
