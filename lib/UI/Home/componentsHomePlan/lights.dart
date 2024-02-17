import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class lights extends StatefulWidget{
  @override
  State<lights> createState() => _lightsState();
}

class _lightsState extends State<lights> {
  bool isLightOn = false;
  void toggleLight() {
    setState(() {
      isLightOn = !isLightOn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isLightOn = !isLightOn;
        });
      },
      child:IconButton(
        icon: Icon(
          color: Colors.amber,

          isLightOn ? Icons.lightbulb : Icons.lightbulb_outline,
          size: 50,
        ),
        onPressed: toggleLight,
      ),
    );
  }
}