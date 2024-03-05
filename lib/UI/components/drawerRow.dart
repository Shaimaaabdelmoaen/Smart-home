import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class drawerRow extends StatelessWidget{
  final IconData drawericons;
  final String drawerIconsText;
  drawerRow({required this.drawericons,required this.drawerIconsText});
  @override
  Widget build(BuildContext context) {
   return Row(
     children: [
       Icon(drawericons),
       SizedBox(width: 20,),
       Text(drawerIconsText,style: TextStyle(fontSize: 20,color: Colors.black),)
     ],
   );
  }

}