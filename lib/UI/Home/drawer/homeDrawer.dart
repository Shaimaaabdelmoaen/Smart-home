import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/Home/drawer/log%20out/logOut.dart';
import 'package:smart_home1/UI/Home/drawer/settings/SettingsComponent/editProfile.dart';
import 'package:smart_home1/UI/Home/drawer/settings/settingsTap.dart';
import 'package:smart_home1/UI/components/drawerRow.dart';

class homeDrawer extends StatefulWidget{
  @override
  State<homeDrawer> createState() => _homeDrawerState();
}
class _homeDrawerState extends State<homeDrawer> {
  late Future<String?> email;

  @override
  void initState() {
    super.initState();
    email = getEmail();
  }

  Future<String?> getEmail() async {//
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child:
      ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(editProfile.routeName);
                  },
                  child: Center(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Shaimaa Abdelmoaen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Center(
                  child: FutureBuilder<String?>(
                    future: getEmail(), // Define a function to retrieve the email
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? 'user@example.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title:drawerRow(drawericons: Icons.settings, drawerIconsText: 'Settings'),
            onTap: () {
              Navigator.pushNamed(context, settingsTap.routeName);
            },
          ),
          ListTile(
            title: drawerRow(drawericons: Icons.logout, drawerIconsText: 'Log Out'),
            onTap: () {
              logout(context);

            },
          ),
        ],
      ),
    );
  }
}