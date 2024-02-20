import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class temperature extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('temperature'),
                  content: Text('.............'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK',style: TextStyle(color: Theme.of(context).secondaryHeaderColor),),
                    ),
                  ],
                ),
          );
        },
        icon: Icon(Icons.thermostat,size: 45,color: Colors.red,));
  }
  
}