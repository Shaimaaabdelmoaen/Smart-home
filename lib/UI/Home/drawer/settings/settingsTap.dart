import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/Home/drawer/settings/SettingsContainer.dart';
import 'package:smart_home1/UI/Home/drawer/settings/themeBottomSheet.dart';
import 'package:smart_home1/UI/register/registerScreen.dart';

import '../../../../provider/settingsProvider.dart';
import 'SettingsComponent/Delete user/delete.dart';
import 'SettingsComponent/chandePassword.dart';
import 'SettingsComponent/userProfile/profile_page.dart';
class settingsTap extends StatefulWidget{
  static const routeName='settingsTap';
  @override
  State<settingsTap> createState() => _settingsTapState();
}

class _settingsTapState extends State<settingsTap> {
  String? role;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
  }
  @override
  Widget build(BuildContext context) {
    var SettingsProvidr =Provider.of<settingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20)
                ),
                height: MediaQuery.of(context).size.height/10,
                width: MediaQuery.of(context).size.width,
                //color: Theme.of(context).primaryColor.withOpacity(.5),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text('Accounts',style: TextStyle(fontSize: 24),),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, ProfilePage.routeName);
                },
                child: SettingeContainer(
                    name: 'Edit Profile',
                    icon1: Icons.person_pin,),
              ),
              Divider(),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, ChangePasswordPage.routeName);
                },
                  child: SettingeContainer(name: 'Change Password', icon1: Icons.key)),
              Divider(),
              if (role == 'Admin') ...[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, registerScreen.routeName);
                  },
                  child: SettingeContainer(
                    name: 'Add User',
                    icon1: Icons.add,
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, UserList.routeName);
                  },
                  child: InkWell(
                    child: SettingeContainer(
                      name: 'Delete User',
                      icon1: Icons.delete,

                    ),
                  ),
                ),
                Divider(),
              ],
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20)
                ),
                height: MediaQuery.of(context).size.height/10,
                width: MediaQuery.of(context).size.width,
                //color: Theme.of(context).primaryColor.withOpacity(.5),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text('Theme',style: TextStyle(fontSize: 24),),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  showThemeBottomSheet(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                     // color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 1
                      )
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            SettingsProvidr.isDarkEnable()
                                ?'dark'
                                :'light',
                            style: TextStyle(color: Colors.black,fontSize: 25,)
                        ),
                        Icon(Icons.dark_mode)
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
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