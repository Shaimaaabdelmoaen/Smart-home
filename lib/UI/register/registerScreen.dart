import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/components/customFormField.dart';

import '../../validation/validationUtilts.dart';

class registerScreen extends StatelessWidget{
  static const routeName='register';
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
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          child: Form(
            key:FormKey , //to access the component
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.stretch ,
                children: [
                  Text('Create Account',
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                  customFormField(
                    prefixIcon: Icon(Icons.person_outline),
                      hintText: 'Full Name',
                      keyboardType:TextInputType.name,
                    validator: (text){
                        if (text==null || text.trim().isEmpty){
                          return 'please enter full name';
              
                        }
                        return null;
                    },
                    controller: fullName,
                  ),
                  customFormField(
                    prefixIcon: Icon(Icons.person_outline),
                      hintText: 'user Name',
                      keyboardType: TextInputType.name,
                    validator: (text){
                      if (text==null || text.trim().isEmpty){
                        return 'please enter user name';
              
                      }
                      return null;
                    },
                    controller: userName,
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
                  customFormField(
                    prefixIcon: Icon(Icons.key),
                    hintText: 'password Confirmation',
                    keyboardType: TextInputType.text,
                    secureText: true,
                    validator: (text){
                      if (text==null || text.trim().isEmpty){
                        return 'please enter password';
              
                      }
                      else if(text.length<6){
                        return 'password should at least 6 chars';
                      }
                      else if(password.text!=text){
                        return 'password does not match';
                      }
                      return null;
                    },
                    controller: passwordConfirmation,
                  ),
                  SizedBox(height: 24,),
                  ElevatedButton(
                      onPressed: (){
                        CreateAccount();
                      },
                      child: Text('SIGN UP',
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


      ),
    );
  }

  void CreateAccount() {
    //if form is valid or not
    if(FormKey.currentState?.validate() == false){
      return;

    }

  }

}