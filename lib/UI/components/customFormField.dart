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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            controller: controller,
            validator: validator,
            obscureText: secureText,
            keyboardType:keyboardType ,
            decoration: InputDecoration(
              hintText: hintText ,
                hintStyle:TextStyle(color: Colors.white) ,
              prefixIcon: prefixIcon,
                prefixIconColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Colors.white)),
              fillColor: Colors.white12,
              filled: true
            ),

          ),
        ),
      ],
    );
  }

}