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
            controller: controller,
            validator: validator,
            obscureText: secureText,
            keyboardType:keyboardType ,
            decoration: InputDecoration(
              hintText: hintText ,
                hintStyle:TextStyle(color: Colors.white) ,
              prefixIcon: prefixIcon,
                prefixIconColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
              fillColor: Colors.black12,
              filled: true
            ),

          ),
        ),
      ],
    );
  }

}