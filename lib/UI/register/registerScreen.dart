import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/login/loginScreen.dart';
import '../../validation/validationUtilts.dart';
import '../components/customFormField.dart';

class registerScreen extends StatelessWidget {
  static const routeName = 'register';

  TextEditingController nameController =
  TextEditingController(text: 'casper1');
  TextEditingController emailController =
  TextEditingController(text: 'casper@gmail.com');
  TextEditingController passwordController = TextEditingController(
      text: '123123');
  TextEditingController password_confirmationController =
  TextEditingController(text: '123123');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/Smart-home-logo.png',
                    width: 100,
                    height: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sign Up',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  customFormField(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: 'Enter your Name',
                    keyboardType: TextInputType.name,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return 'please enter user name';
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  customFormField(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'ex@gmail.com',
                    keyboardType: TextInputType.emailAddress,
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
                    controller: emailController,
                  ),
                  customFormField(
                    prefixIcon: Icon(Icons.key),
                    hintText: 'Enter your password',
                    keyboardType: TextInputType.text,
                    secureText: true,
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
                    controller: passwordController,
                  ),
                  customFormField(
                    prefixIcon: Icon(Icons.key),
                    hintText: 'password Confirmation ',
                    keyboardType: TextInputType.text,
                    secureText: true,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return 'please enter password';
                      }
                      else if (text.length < 5) {
                        return 'password should at least 5 chars';
                      }
                      else if (passwordController.text != text) {
                        return 'password does not match';
                      }
                      return null;
                    },
                    controller: password_confirmationController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, loginScreen.routeName);

                        },
                        child: Text("Already a member? Sign In",style: TextStyle(color: Colors.white),),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            registerUser(context);
                            print('success');
                          }
                          else {
                            print('unsuccess');
                          }
                          //createAccount(context);
                        },
                        child: Text(
                          'Create account',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Color(0xFF7D7D7E)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    final url = Uri.parse(
        'https://75b9-41-46-40-131.ngrok-free.app/api/register');
    final response = await http.post(
      url,
      body: jsonEncode({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': password_confirmationController.text,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      Navigator.pushNamed(context, loginScreen.routeName);

      //Navigator.of(context).pop(); // Navigate back to previous screen after successful registration.
    } else {
      // Handle registration error.
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Registration Failed'),
              content: Text('Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }
}