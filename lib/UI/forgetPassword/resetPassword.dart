import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/login/loginScreen.dart';
import '../../api/constant.dart';
import '../../validation/validationUtilts.dart';

class PasswordResetPage extends StatefulWidget {
  static const routeName='resetpassword';
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  Future<void> _resetPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return;
    }
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String passwordConfirmation = _passwordConfirmationController.text;

      final Map<String, dynamic> requestData = {
        'token': token,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
      final String apiUrl = '${Constant.base_url}reset-password-mobile';
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestData),
        );
        print("response.body");
        print(response.body);

        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: 'Password reset successful', toastLength: Toast.LENGTH_SHORT);
        } else {
          Fluttertoast.showToast(msg: 'Password reset failed', toastLength: Toast.LENGTH_SHORT);
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error: $e', toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (text) {
                  if (text == null || text
                      .trim()
                      .isEmpty) {
                    return 'please enter email';
                  }
                  else if (!isvalidEmail(text)) {
                    return 'email bad format';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (text) {
                  if (text == null || text
                      .trim()
                      .isEmpty) {
                    return 'please enter password';
                  }
                  else if (text.length < 5) {
                    return 'password should at least 5 chars';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordConfirmationController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (text) {
                  if (text == null || text
                      .trim()
                      .isEmpty) {
                    return 'please enter password';
                  }
                  else if (text.length < 5) {
                    return 'password should at least 5 chars';
                  }
                  else if (_passwordController.text != text) {
                    return 'password does not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, loginScreen.routeName);
                },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}