import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/forgetPassword/EnterCodePage.dart';
import 'package:http/http.dart' as http;
import 'package:smart_home1/api/constant.dart';

class CheckEmailPage extends StatefulWidget {
  static const routeName = 'checkEmail';

  @override
  _CheckEmailPageState createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  final TextEditingController _emailController = TextEditingController(text: 'sa3073@fayoum.edu.eg');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String message = '';

  Future<void> _checkEmailAndNavigate(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('${Constant.base_url}forgot-password-mobile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final bool? status  = responseData['status'];

        if (status ==true) {
          Navigator.pushNamed(context, OtpVerificationScreen.routeName);
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to check email.');
      }
    } catch (error) {
      setState(() {
        message = 'Error: $error';
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
              onPressed: () => _checkEmailAndNavigate(context),
              child: Text('Next'),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}