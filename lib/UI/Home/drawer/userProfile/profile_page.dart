import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/display_image_widget.dart';
import 'user/user_data.dart';
import 'pages/edit_email.dart';
import 'pages/edit_image.dart';
import 'pages/edit_name.dart';
// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  static const routeName='userprofile';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                    ))),
            InkWell(
                onTap: () {
                  navigateSecondPage(EditImagePage());
                },
                child: DisplayImage(
                  imagePath: user.image,
                  onPressed: () {},
                )),
            buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
            buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          ],
        ),
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
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
                    ))),
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
                    ])),
              )
            ],
          ));

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
