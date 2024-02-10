import 'package:flutter/material.dart';
import 'package:smart_home1/UI/Home/homeScreen.dart';
import 'package:smart_home1/UI/login/loginScreen.dart';
import 'package:smart_home1/UI/register/registerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 20)
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        homeScreen.routeName:(_)=>homeScreen(),
        registerScreen.routeName:(_)=>registerScreen(),
        loginScreen.routeName:(_)=>loginScreen(),
      },
      initialRoute: registerScreen.routeName,
    );
  }
}