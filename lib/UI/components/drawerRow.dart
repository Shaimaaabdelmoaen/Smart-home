import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class drawerRow extends StatelessWidget{
  final IconData drawericons;
  final String drawerIconsText;
  String name;
  drawerRow({required this.drawericons,required this.drawerIconsText,required this.name});
  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: (){
       Navigator.pushNamed(context, name);
     },
     child: Row(
       children: [
         Icon(drawericons),
         SizedBox(width: 20,),
         Text(drawerIconsText,style: TextStyle(fontSize: 20,color: Colors.black),)
       ],
     ),
   );
  }

}