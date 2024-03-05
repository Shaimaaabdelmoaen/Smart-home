import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/components/spaces/space.05.dart';
import 'package:smart_home1/UI/login/loginScreen.dart';
import '../../validation/validationUtilts.dart';
import '../components/customFormField.dart';

class registerScreen extends StatelessWidget {
  static const routeName = 'register';

  TextEditingController nameController =
  TextEditingController(text: 'shaimaa');
  TextEditingController emailController =
  TextEditingController(text: 'sa3073@fayoum.edu.eg');
  TextEditingController passwordController = TextEditingController(
      text: 'pit%TLB7');
  TextEditingController password_confirmationController =
  TextEditingController(text: 'pit%TLB7');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top:mediaQuery.size.height*.06,right: mediaQuery.size.width*.025,left: mediaQuery.size.width*.025),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/undraw_hire_re_gn5j.png',
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height*.14,
                  ),
                  Text(
                    'Sign Up',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
                  ),
                  SizedBox(height: 10,),
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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, loginScreen.routeName);

                        },
                        child: Text("Already a member?Sign In",style: TextStyle(fontSize: 15,color: Colors.white),),
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
                  SizedBox(height: 10,),
                  Container(
                    width: mediaQuery.size.width,
                    alignment:  Alignment.bottomRight,
                    child: Image.asset(
                      'assets/images/undraw_join_re_w1lh.png',
                      width: mediaQuery.size.width*.2,
                      height: mediaQuery.size.height*.1,
                    ),
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
        'https://48f4-154-178-220-91.ngrok-free.app/api/register');
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
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Registration Failed'),
              content: Text('Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK',style: TextStyle(color: Theme.of(context).secondaryHeaderColor),),
                ),
              ],
            ),
      );
    }
  }
}