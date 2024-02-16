import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/Home/drawer/log%20out/logOut.dart';
import 'package:smart_home1/UI/Home/drawer/settings/settingsTap.dart';
import 'package:smart_home1/UI/components/drawerRow.dart';

class homeDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text('Home Assistant',
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  Divider(color: Colors.black38,height: 12,),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  drawerRow(drawericons: Icons.settings,drawerIconsText: 'Settings',name: settingsTap.routeName,),
                  drawerRow(drawericons: Icons.logout_outlined,drawerIconsText: 'Log Out',name: logOut.routeName,),
                ],
              ),
            ),

          ],

        ),
      ),
    );
  }

}