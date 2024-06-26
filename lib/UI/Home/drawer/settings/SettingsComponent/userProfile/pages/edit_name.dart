import 'package:flutter/material.dart';
import '../user/user_data.dart';
import '../widgets/appbar_widget.dart';

class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);
  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  void updateUserValue(String name) {
    user.name = name;
  }
  bool isAlpha(String value) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:BuildAppBar(appName: 'Edit Name',),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                          child: SizedBox(
                              height: 100,
                              width: 150,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  } else if (!isAlpha(value)) {
                                    return 'Only Letters Please';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: 'First Name'),
                                controller: firstNameController,
                              )
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                          child: SizedBox(
                              height: 100,
                              width: 150,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  } else if (!isAlpha(value)) {
                                    return 'Only Letters Please';
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(labelText: 'Last Name'),
                                controller: secondNameController,
                              )))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 330,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    isAlpha(firstNameController.text +
                                        secondNameController.text)) {
                                  updateUserValue(firstNameController.text +
                                      " " +
                                      secondNameController.text);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                      )
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
