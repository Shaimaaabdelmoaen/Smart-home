import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SetNewPasswordPage extends StatefulWidget {
  static const routename='SetNewPasswordPage';
  @override
  _SetNewPasswordPageState createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password_confirmationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _message = '';

  Future<void> _setNewPassword(String email, String password,String password_confirmation) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://your-api-url/set-new-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'password_confirmation':password_confirmation
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _message = 'Password updated successfully.';
        });
      } else {
        throw Exception('Failed to update password.');
      }
    } catch (error) {
      setState(() {
        _message = 'Error: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set New Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'New Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _password_confirmationController,
                    decoration: InputDecoration(labelText: 'password_confirmation'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final password = _passwordController.text.trim();
                        final password_confirmation=_password_confirmationController.text.trim();
                        final email = 'user@example.com'; // Use the user's email here
                        _setNewPassword(email, password,password_confirmation);
                      }
                    },
                    child: Text('Set New Password'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(_message),
          ],
        ),
      ),
    );
  }
}