import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/login/loginScreen.dart';
import 'package:smart_home1/api/constant.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top:40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/undraw_hire_re_gn5j.png',
                        width: screenWidth,
                        height: mediaQuery.size.height/7,
                      ),
                      Text(
                        'Add User',
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
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.arrow_back_sharp)),
                          Image.asset(
                            'assets/images/undraw_join_re_w1lh.png',
                            width: screenWidth/3,
                            height: screenHeight/6,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    final url = Uri.parse(
        '${Constant.base_url}register');
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