import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/Home/drawer/log%20out/logOut.dart';
import 'package:smart_home1/UI/Home/drawer/settings/SettingsComponent/userProfile/profile_page.dart';
import 'package:smart_home1/UI/Home/drawer/settings/settingsTap.dart';
import 'package:smart_home1/UI/components/drawerRow.dart';

class homeDrawer extends StatefulWidget{
  @override
  State<homeDrawer> createState() => _homeDrawerState();
}
class _homeDrawerState extends State<homeDrawer> {
  String? role;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    email = getEmail();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }

  late Future<String?> email;

  Future<String?> getEmail() async {
    //
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
  void _showGenerateOtpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('use this OTP to open door'),
          content: Text('OTP generation process initiated.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfilePage.routeName);
                  },
                  child: Center(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/Robots-Square.png') /*NetworkImage('https://via.placeholder.com/150')*/,
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
                    future: getEmail(),
                    // Define a function to retrieve the email
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? 'shaimaa@fayoum.edu.eg',
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
          if (role == 'Admin') ...[
            ListTile(
              title: drawerRow(drawericons: Icons.smart_button_outlined,
                  drawerIconsText: 'Generate OTP'),
              onTap: () {
                _showGenerateOtpDialog(context);

              },
            ),
          ],
          ListTile(
            title: drawerRow(
                drawericons: Icons.settings, drawerIconsText: 'Settings'),
            onTap: () {
              Navigator.pushNamed(context, settingsTap.routeName);
            },
          ),
          ListTile(
            title: drawerRow(
                drawericons: Icons.logout, drawerIconsText: 'Log Out'),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),

    );
  }
}