/*import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/forgetPassword/ChangePasswordPage.dart';
import 'package:http/http.dart' as http;

class EnterCodePage extends StatelessWidget {
  static const routeName = 'enterCode';

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  Future<void> _verifyCodeAndNavigate(BuildContext context) async {
    final code = _codeController.text.trim();
    final email = _emailController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://b5de-41-46-16-22.ngrok-free.app/api/verify-otp-mobile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'otp': code
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 302) {
        if (response.statusCode == 200) {
          final location = response.headers['location'];
          if (location != null) {
            final redirectResponse = await http.get(Uri.parse(location));
            // Process the redirect response as needed
            // For example, you can extract the token from the redirectResponse
            final redirectData = json.decode(redirectResponse.body);
            final String? token = redirectData['token'];

            // Navigate to the next screen (e.g., ChangePasswordPage) with the token
            Navigator.pushNamed(
              context,
              ChangePasswordPage.routeName,
              arguments: {'token': token},
            );
          }
        } else {
          final responseData = json.decode(response.body);
          final bool? status = responseData['status'];
          final String? message = responseData['message'];
          final String? token = responseData['token'];

          if (status == true && message == 'OTP is valid') {
            Navigator.pushNamed(
              context,
              ChangePasswordPage.routeName,
              arguments: {'token': token},
            );
          } else {
            throw Exception('Invalid verification code');
          }
        }
      } else {
        throw Exception('Failed to verify OTP');
      }
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
        title: Text('Enter Verification Code'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _verifyCodeAndNavigate(context),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'ChangePasswordPage.dart';

class EnterCodePage extends StatelessWidget {
  static const routeName = 'enterCode';
  final Logger _logger = Logger();

  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  Future<void> _verifyOTP(BuildContext context) async {
    final otp = _otpController.text.trim();
    final email = _emailController.text.trim();


    try {
      final response = await http.post(
        Uri.parse('https://b5de-41-46-16-22.ngrok-free.app/api/verify-otp-mobile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email':email,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final bool? status = responseData['status'];
        final String? message = responseData['message'];
        final String? token = responseData['token'];

        if (status == true && message == 'OTP is valid') {
          Navigator.pushNamed(
            context,
            ChangePasswordPage.routeName,
            arguments: {'token': token},
          );
        } else {
          throw Exception('Invalid OTP');
        }
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch (error) {
      _logger.e('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Verification Code'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Verification Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _verifyOTP(context),
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'ChangePasswordPage.dart';

class EnterCodePage extends StatelessWidget {
  static const routeName = 'enterCode';
  final Logger _logger = Logger();

  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _verifyOTP(BuildContext context) async {
    final otp = _otpController.text.trim();
    final email = _emailController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://b5de-41-46-16-22.ngrok-free.app/api/verify-otp-mobile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final String? status = responseData['status'];
        final String? message = responseData['message'];
        final String? token = responseData['token'];

        if (status == "true") {
          Navigator.pushNamed(
            context,
            ChangePasswordPage.routeName,
            arguments: {'token': token},
          );
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to verify OTP. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      //_logger.e('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Verification Code'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Verification Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _verifyOTP(context),
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}