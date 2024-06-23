import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/Home/drawer/settings/SettingsComponent/userProfile/pages/edit_email.dart';
import 'package:smart_home1/UI/Home/drawer/settings/SettingsComponent/userProfile/pages/edit_image.dart';
import 'package:smart_home1/UI/Home/drawer/settings/SettingsComponent/userProfile/pages/edit_name.dart';
import 'package:smart_home1/UI/Home/drawer/settings/SettingsComponent/userProfile/widgets/appbar_widget.dart';
import 'package:smart_home1/UI/Home/drawer/settings/SettingsComponent/userProfile/widgets/display_image_widget.dart';
class editProfile extends StatefulWidget {
  static const routeName='userprofile';
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(appName: 'Edit profile'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  navigateSecondPage(EditImagePage());
                },
                child:Center(
                  child: CircleAvatar(
                    radius:100,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                ), /*DisplayImage(
                  imagePath: AssetImage(''),
                  onPressed: () {},
                )*/
            ),
             buildUserInfoDisplay('Name', 'Name',EditNameFormPage()),
             buildUserInfoDisplay( 'Email','Email', EditEmailFormPage()),
          ],
        ),
      ),
    );
  }
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              InkWell(
                onTap: (){
                  navigateSecondPage(editPage);
                },
                child: Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    )
                        )
                    ),
                    child: Row(
                        children: [
                      Expanded(
                              child: Text(
                                getValue,
                                style: TextStyle(fontSize: 20, height: 1.4,color: Theme.of(context).primaryColor),
                              )),
                      Icon(
                        Icons.edit_note,
                        color: Colors.grey,
                        size: 40.0,
                      )
                    ]
                    )
                ),
              )
            ],
          )
      );

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
