import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/settingsProvider.dart';
class themeBottomSheet extends StatefulWidget{
  @override
  State<themeBottomSheet> createState() => _themeBottomSheetState();
}

class _themeBottomSheetState extends State<themeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var SettingsProvider=Provider.of<settingsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: (){
                  SettingsProvider.changeTheme(ThemeMode.light);

                },
                child:
                SettingsProvider.isDarkEnable()
                    ?getunSelectedItem('Light')
                    :getSelectedItem("Light")
            ),
            InkWell(
                onTap: (){
                  SettingsProvider.changeTheme(ThemeMode.dark);

                },

                child: SettingsProvider.isDarkEnable()
                    ?getSelectedItem("Dark")
                    :getunSelectedItem('Dark')
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItem(String text){
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween ,
      children: [
        Text(text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary)),
        Icon(Icons.check,color: Theme.of(context).colorScheme.secondary,)
      ],
    );

  }

  Widget getunSelectedItem(String text){
    return Row(
        children: [
          Text(text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).secondaryHeaderColor),
          ),
        ]
    )
    ;

  }
}