import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_home1/UI/Home/drawer/log%20out/logOut.dart';
import 'package:smart_home1/UI/Home/drawer/settings/settingsTap.dart';
import 'package:smart_home1/UI/Home/homeScreen.dart';
import 'package:smart_home1/UI/login/loginScreen.dart';
import 'package:smart_home1/UI/myThemeData.dart';
import 'package:smart_home1/UI/register/registerScreen.dart';
import 'package:smart_home1/provider/settingsProvider.dart';

//final GetIt getIt = GetIt.instance;
/*void setupLocator() {
  GetIt.I.registerLazySingleton(() => LoginViewModel());
  // Register other services and view models here
}*/

void main() {
  //setupLocator();
  runApp(ChangeNotifierProvider(
    create: (buildContext)=>settingsProvider() ,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    settingsProvider SettingsProvider=
    Provider.of<settingsProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: SettingsProvider.currentTheme,
      theme: myThemeData.lightTheme,
      darkTheme: myThemeData.darkTheme,
      routes: {
        homeScreen.routeName:(_)=>homeScreen(),
        registerScreen.routeName:(_)=>registerScreen(),
        loginScreen.routeName:(_)=>loginScreen(),
        settingsTap.routeName:(_)=>settingsTap(),
        logOut.routeName:(_)=>logOut(),
      },
      initialRoute: homeScreen.routeName,
    );
  }
}