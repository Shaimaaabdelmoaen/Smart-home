import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home1/UI/Home/drawer/settings/themeBottomSheet.dart';

import '../../../../provider/settingsProvider.dart';
class settingsTap extends StatefulWidget{
  static const routeName='settingsTap';
  @override
  State<settingsTap> createState() => _settingsTapState();
}

class _settingsTapState extends State<settingsTap> {
  @override
  Widget build(BuildContext context) {
    var SettingsProvidr =Provider.of<settingsProvider>(context);
    return Scaffold(
      backgroundColor:Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: 64,
            horizontal: 18
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600)),
            InkWell(
              onTap: (){
                showThemeBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Theme.of(context).dividerColor,width: 1
                    )
                ),
                child:  Text(
                    SettingsProvidr.isDarkEnable()
                        ?'dark'
                        :'light',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }

 void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context,
        builder: (context){
          return themeBottomSheet();

        });
  }


}