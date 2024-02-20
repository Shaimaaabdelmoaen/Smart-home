import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class door extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('opened door'),
                  content: Text('***********'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK',style: TextStyle(color: Theme.of(context).secondaryHeaderColor),),
                    ),
                  ],
                ),
          );
        },
        icon: Icon(Icons.door_back_door_outlined,size: 40,color: Colors.blue,));
  }

}