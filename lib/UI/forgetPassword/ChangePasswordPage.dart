import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatelessWidget {
  static const routeName = 'changePassword';

  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password_confirmationController = TextEditingController();


  Future<void> _changePassword(BuildContext context) async {
    final token = _passwordController.text.trim();
    final email = _passwordController.text.trim();
    final password = _passwordController.text.trim();
    final password_confirmation = _passwordController.text.trim();


    try {
      final response = await http.post(
        Uri.parse('https://b5de-41-46-16-22.ngrok-free.app/api/reset-password-mobile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'token':token,
          'email':email,
          'password': password,
          'password_confirmation':password_confirmation
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password changed successfully')),
        );
        Navigator.popUntil(context, ModalRoute.withName('/'));
      } else {
        throw Exception('Failed to change password');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully')),
      );

      Navigator.popUntil(context, ModalRoute.withName('/'));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _changePassword(context),
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}