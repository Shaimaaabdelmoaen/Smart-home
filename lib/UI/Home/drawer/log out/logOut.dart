import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_home1/UI/login/loginScreen.dart';

Future<void> logout(BuildContext context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http.post(
      Uri.parse('https://yourapi.com/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to log out');
    }
    await prefs.clear();
    Navigator.pushReplacementNamed(context, loginScreen.routeName);
  } catch (e) {
    print('Error during logout: $e');
  }
}