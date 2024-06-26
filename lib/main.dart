import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_home1/UI/Home/SmartDevices/smartDivicesSection.dart';
import 'package:smart_home1/UI/Home/componentsHomePlan/temperature.dart';
import 'package:smart_home1/UI/Home/drawer/log%20out/logOut.dart';
import 'package:smart_home1/UI/Home/drawer/settings/settingsTap.dart';
import 'package:smart_home1/UI/Home/homeScreen.dart';
import 'package:smart_home1/UI/components/fingerPrint/FingerPrint.dart';
import 'package:smart_home1/UI/forgetPassword/EnterCodePage.dart';
import 'package:smart_home1/UI/forgetPassword/checkEmail.dart';
import 'package:smart_home1/UI/login/loginScreen.dart';
import 'package:smart_home1/UI/myThemeData.dart';
import 'package:smart_home1/UI/register/registerScreen.dart';
import 'package:smart_home1/provider/settingsProvider.dart';

import 'UI/Home/camera/VideoStreamScreen.dart';
import 'UI/Home/camera/another code.dart';
import 'UI/Home/drawer/settings/SettingsComponent/Delete user/delete.dart';
import 'UI/Home/drawer/settings/SettingsComponent/chandePassword.dart';
import 'UI/Home/drawer/settings/SettingsComponent/userProfile/pages/edit_name.dart';
import 'UI/Home/drawer/settings/SettingsComponent/userProfile/profile_page.dart';
import 'UI/forgetPassword/resetPassword.dart';

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
      debugShowCheckedModeBanner:false,
      themeMode: SettingsProvider.currentTheme,
      theme: myThemeData.lightTheme,
      darkTheme: myThemeData.darkTheme,
      routes: {
        homeScreen.routeName:(_)=>homeScreen(),
        registerScreen.routeName:(_)=>registerScreen(),
        loginScreen.routeName:(_)=>loginScreen(),
        settingsTap.routeName:(_)=>settingsTap(),
        FingerPrint.routeName:(_)=>FingerPrint(),
        CheckEmailPage.routeName:(_)=>CheckEmailPage(),
        //EnterCodePage.routeName: (context) => EnterCodePage(),
        OtpVerificationScreen.routeName:(_)=>OtpVerificationScreen(),
        //ChangePasswordPage.routeName: (context) => ChangePasswordPage(),
        PasswordResetPage.routeName:(_)=>PasswordResetPage(),
        ChangePasswordPage.routeName:(_)=>ChangePasswordPage(),
        smartDevicesSection.routeName:(_)=>smartDevicesSection(),
        IPWebcamScreen.routeName:(_)=>IPWebcamScreen(),
        UserList.routeName:(_)=>UserList(),
        ProfilePage.routeName:(_)=>ProfilePage(),
        //checkEmail.routename:(_)=>checkEmail(),
        //SetNewPasswordPage.routename:(_)=>SetNewPasswordPage()
      },
      initialRoute: homeScreen.routeName,
    );
  }
}