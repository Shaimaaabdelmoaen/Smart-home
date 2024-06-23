import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../validation/validationUtilts.dart';
import '../widgets/appbar_widget.dart';
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(appName: 'Edit Email',),
          body: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          width: 320,
                          child: const Text(
                            "What's your email?",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: SizedBox(
                              height: 100,
                              width: 320,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email.';
                                  }
                                  else if (!isvalidEmail(value)) {
                                    return 'email bad format';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Your email address'),
                                controller: emailController,
                              ))),
                      Padding(
                          padding: EdgeInsets.only(top: 150),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: 320,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        EmailValidator.validate(
                                            emailController.text)
                                    )
                                      {}
                                  },
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              )
                          )
                      )
                    ]
                ),
              ),
            ),
          )
    );
  }
}