import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/Home/homeScreen.dart';
import 'dart:convert';

import 'package:smart_home1/api/constant.dart';

import '../../../../../validation/validationUtilts.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routeName='ChangePasswordPage';
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return;
    }
    final response = await http.post(
      Uri.parse('${Constant.base_url}change-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'old_password': _oldPasswordController.text,
        'new_password': _newPasswordController.text,
        'new_password_confirmation': _confirmPasswordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final message = responseBody['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to change password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (text){
                  if (text==null || text.trim().isEmpty){
                    return 'please enter email';

                  }
                  else if(!isvalidEmail(text)){
                    return 'email bad format';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _oldPasswordController,
                decoration: InputDecoration(labelText: 'Old Password'),
                validator: (text){
                  if (text==null || text.trim().isEmpty){
                    return 'please enter old password';
                  }
                  else if(text.length<6){
                    return 'password should at least 6 chars';
                  }
                  return null;
                },
                obscureText: true,
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                validator: (text){
                  if (text==null || text.trim().isEmpty){
                    return 'please enter new password';
                  }
                  else if(text.length<6){
                    return 'password should at least 6 chars';
                  }
                  return null;
                },
                obscureText: true,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                validator: (text) {
                  if (text == null || text
                      .trim()
                      .isEmpty) {
                    return 'please enter password';
                  }
                  else if (text.length < 5) {
                    return 'password should at least 5 chars';
                  }
                  else if (_newPasswordController.text != text) {
                    return 'password does not match';
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, homeScreen.routeName);
                },
                child: Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}