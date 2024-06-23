import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingeContainer extends StatelessWidget{
  String name;
  IconData? icon1;
  SettingeContainer({required this.name,required this.icon1});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/10,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Icon(
            icon1,color: Theme.of(context).iconTheme.color,
            size: Theme.of(context).iconTheme.size,
          ),
          SizedBox(width: 10,),
          Text(name,style: TextStyle(fontSize: 22,color: Colors.black),),
          Spacer(),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.arrow_forward_sharp)
          )
        ],
      ),
    );
  }

}