
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/Home/homeScreen.dart';
import 'package:smart_home1/UI/components/customFormField.dart';
import 'package:smart_home1/UI/components/spaces/space.05.dart';
import 'package:smart_home1/UI/forgetPassword/checkEmail.dart';
import 'package:smart_home1/UI/register/registerScreen.dart';
import 'package:http/http.dart'as http;

import '../../api/ApiManager.dart';
import '../../validation/validationUtilts.dart';
class loginScreen extends StatelessWidget{
  String userName = '';
  String userEmail = '';

  static const routeName='login';
  TextEditingController email=TextEditingController(text: 'sa3073@fayoum.edu.eg');
  TextEditingController password=TextEditingController(text: '12345678');
  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key:FormKey , //to access the component
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.stretch ,
                children: [
                  Image.asset('assets/images/undraw_mobile_encryption_re_yw3.png',
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height*.25,
                  ),
                  space1(),
                  Text('SMART HOME',
                    textAlign:  TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    color: Colors.white,
                  ),
                  ),
                  space1(),
                  customFormField(
                    prefixIcon: Icon(Icons.email),
                      hintText: 'ex@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if (text==null || text.trim().isEmpty){
                        return 'please enter email';

                      }
                      else if(!isvalidEmail(text)){
                        return 'email bad format';
                      }
                      return null;
                    },
                    controller: email,
                  ),
                  space1(),
                  customFormField(
                    prefixIcon: Icon(Icons.key),
                      hintText: '********',
                      keyboardType: TextInputType.text,
                      secureText: true,
                    validator: (text){
                      if (text==null || text.trim().isEmpty){
                        return 'please enter password';
                      }
                      else if(text.length<6){
                        return 'password should at least 6 chars';
                      }
                      return null;
                    },
                    controller: password,
                  ),
                  space1(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, registerScreen.routeName);

                            },
                            child: Text("you don’t have Account? Register",style: TextStyle(
                                color: Colors.white,
                              fontSize: 15
                            ),),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, CheckEmailPage.routeName);

                            },
                            child: Text("forget password",style: TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Login(context);
                        },
                        child: Text('Log In',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color(0xFF7D7D7E),
                          ),
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
  Future<void> Login(BuildContext context) async {
    if (FormKey.currentState?.validate() == false) {
      return;
    }

    try {
      final token = await APIManager.login(email.text, password.text);
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        final email = await getEmail();//
        print('Logged in with email: $email');//
        Navigator.pushNamed(context, homeScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  Future<String?> getEmail() async {//
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }


  }
class LoginResponse {
  final User user;
  final String token;

  LoginResponse({required this.user, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
