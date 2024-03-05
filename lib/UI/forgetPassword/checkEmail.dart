import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class checkEmail extends StatefulWidget {
  static const routename='checkEmail';
  @override
  _checkEmailState createState() => _checkEmailState();
}

class _checkEmailState extends State<checkEmail> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _message = '';


  Future<void> _checkEmailAndResetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://7bb2-41-46-41-111.ngrok-free.app/api/forgot-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final bool emailExists = responseData['emailExists'];

        if (emailExists) {
          final resetResponse = await http.post(
            Uri.parse('https://7bb2-41-46-41-111.ngrok-free.appapi/reset-password'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{'email': email}),
          );

          if (resetResponse.statusCode == 200 || response.statusCode == 201) {
            setState(() {
              _message = 'Password reset email sent.';
            });
          } else {
            throw Exception('Failed to send reset password email.');
          }
        } else {
          throw Exception('Email not found.');
        }
      } else {
        throw Exception('Failed to check email.');
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
        title: Text('Reset Password'),
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
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkEmailAndResetPassword,
              child: Text('Reset Password'),
            ),
            SizedBox(height: 20),
            Text(_message),
          ],
        ),
      ),
    );
  }
}