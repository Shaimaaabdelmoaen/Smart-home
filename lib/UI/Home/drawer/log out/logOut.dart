import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:smart_home1/UI/login/loginScreen.dart';

import '../../../../api/constant.dart';

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  if (token == null) {
    return;
  }
  final url = '${Constant.base_url}logout';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => loginScreen()),
    );
  } else {
    final errorResponse = json.decode(response.body);
    print('Error: ${errorResponse['message']}');
  }
}