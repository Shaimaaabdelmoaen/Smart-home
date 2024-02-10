import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);
class customFormField extends StatelessWidget{
  String hintText;
  TextInputType keyboardType;
  bool secureText;
  Validator? validator;
  TextEditingController? controller;
  Icon prefixIcon;
  customFormField({
    required this.hintText,
    this.keyboardType=TextInputType.text,
    this.secureText=false,
    this.validator,
    this.controller,
    required this.prefixIcon
  }
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes the position of the shadow
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          validator: validator,
          obscureText: secureText,
          keyboardType:keyboardType ,
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
            fillColor: Colors.white,
            filled: true
          ),

        ),
      ),
    );
  }

}