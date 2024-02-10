import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/components/customFormField.dart';

import '../../validation/validationUtilts.dart';

class loginScreen extends StatelessWidget{
  static const routeName='login';
  TextEditingController fullName=TextEditingController();
  TextEditingController userName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController passwordConfirmation=TextEditingController();
  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('assets/images/background.jpg',),
        fit: BoxFit.fill)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(12),
          child: Form(
            key:FormKey , //to access the component
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.stretch ,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
                customFormField(
                  prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  validator: (text){
                    if (text==null || text.trim().isEmpty){
                      return 'please enter email';

                    }
                    else if(!isvalidEmail(text)){
                      return 'email bad format';
                    }
                    return null;
                  },
                  controller: email,
                ),
                customFormField(
                  prefixIcon: Icon(Icons.key),
                    hintText: 'Password',
                    keyboardType: TextInputType.text,
                    secureText: true,
                  validator: (text){
                    if (text==null || text.trim().isEmpty){
                      return 'please enter password';
                    }
                    else if(text.length<6){
                      return 'password should at least 6 chars';
                    }
                    return null;
                  },
                  controller: password,
                ),
                SizedBox(height: 24,),
                ElevatedButton(
                  onPressed: (){
                    Login();
                  },
                  child: Text('LOGIN',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.cyan
                    ),
                  ),

                )
              ],
            ),
          ),
        ),


      ),
    );
  }

  void Login() {
    //if form is valid or not
    if(FormKey.currentState?.validate() == false){
      return;

    }

  }

}