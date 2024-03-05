import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/Home/drawer/log%20out/logOut.dart';
import 'package:smart_home1/UI/Home/drawer/settings/settingsTap.dart';
import 'package:smart_home1/UI/components/drawerRow.dart';

class homeDrawer extends StatefulWidget{
  @override
  State<homeDrawer> createState() => _homeDrawerState();
}

class _homeDrawerState extends State<homeDrawer> {
  Map<String, dynamic> userData = {};
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse('https://your-api-url.com/user-data'));
    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load user data');
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    userData['name'] ?? 'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    userData['email'] ?? 'user@example.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
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
              Navigator.pushNamed(context, logOut.routeName);

            },
          ),
        ],
      ),
    );
  }
}