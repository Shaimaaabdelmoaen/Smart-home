import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                      fontSize: 20,
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
                  drawerRow(drawericons: Icons.dashboard,drawerIconsText: 'Overview',),
                  drawerRow(drawericons: Icons.energy_savings_leaf_outlined,drawerIconsText: 'Energy',),
                  drawerRow(drawericons: Icons.person_pin_sharp,drawerIconsText: 'Map',),
                ],
              ),
            ),
            Expanded(
              flex:2,
              child: Column(
                children: [
                  Divider(color: Colors.black38,height: 12,),
                  drawerRow(drawericons: Icons.notifications,drawerIconsText: 'Notification',),
                  drawerRow(drawericons: Icons.panorama_fisheye_sharp,drawerIconsText: 'Demo User',),
                ],
              ),
            )

          ],

        ),
      ),
    );
  }

}