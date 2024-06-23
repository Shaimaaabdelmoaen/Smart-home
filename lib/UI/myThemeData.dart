import 'package:flutter/material.dart';

class myThemeData{
  static bool isDarkEnabled=false;
  static Color lightPrimary =Colors.white;
  static Color darkPrimary=Color(0xFF141A2E);
  static Color darkSecondary=Color(0xFFF8C91E);
  static ThemeData lightTheme=ThemeData(
      textTheme:TextTheme(
          titleMedium: TextStyle(
              fontSize: 20,
              //fontWeight: FontWeight.w400,
              color: Colors.black
          ),
          headlineSmall: TextStyle(fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black),
          bodyMedium: TextStyle(
              //fontWeight: FontWeight.w600,
              fontSize:20,
              color: Colors.black
          )
      ) ,
      dividerColor:Colors.black38 ,
      primaryColor: Color(0xFFC48657),
      secondaryHeaderColor: Colors.black,
      scaffoldBackgroundColor:Colors.white ,
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFC48657),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 30
          )
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFC48657),
          primary:Color(0xFFC48657) ,
          secondary: Color(0xFFC48657),
          onPrimary: Colors.white,
          onSecondary: Color(0xFF262D3B33),
          background: Colors.white,

      ),
      iconTheme: IconThemeData(
          color:Color(0xFFC48657),
        size: 30
      ),
      useMaterial3: true,
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white)
  );
  static ThemeData darkTheme=ThemeData(
      textTheme:TextTheme(
          titleMedium: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
          headlineSmall: TextStyle(fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white),
          bodyMedium: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white
          )
      ) ,
      dividerColor:darkSecondary ,
      primaryColor: darkPrimary,
      secondaryHeaderColor: Colors.white,
      scaffoldBackgroundColor:Colors.white ,
      appBarTheme: AppBarTheme(
          backgroundColor: darkPrimary,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 30
          )
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: darkPrimary,
          primary:darkPrimary ,
          secondary: darkSecondary,
          onPrimary: Colors.white,
          onSecondary: Color(0xFF455899),
          background: darkPrimary
      ),
      useMaterial3: true,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkPrimary,
      )
  );
}