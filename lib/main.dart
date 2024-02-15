import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_home1/UI/Home/homeScreen.dart';
import 'package:smart_home1/UI/login/loginScreen.dart';
import 'package:smart_home1/UI/register/registerScreen.dart';

//final GetIt getIt = GetIt.instance;
/*void setupLocator() {
  GetIt.I.registerLazySingleton(() => LoginViewModel());
  // Register other services and view models here
}*/

void main() {
  //setupLocator();
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
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 20)
        ),
        primaryColor: Color(0xFFC48657),

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFC48657),
            onPrimary: Colors.white,
            onSecondary: Colors.black
        ),
        useMaterial3: true,
      ),
      routes: {
        homeScreen.routeName:(_)=>homeScreen(),
        registerScreen.routeName:(_)=>registerScreen(),
        loginScreen.routeName:(_)=>loginScreen(),
      },
      initialRoute: loginScreen.routeName,
    );
  }
}