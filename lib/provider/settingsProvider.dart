import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class settingsProvider extends ChangeNotifier{
  ThemeMode currentTheme=ThemeMode.light;
  void changeTheme(ThemeMode newTheme){
    if(newTheme==currentTheme)return;
    currentTheme=newTheme;
    notifyListeners();
  }
  bool isDarkEnable(){
    return currentTheme ==ThemeMode.dark;
  }
}