import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class lights extends StatefulWidget {
  final Function(bool) onLightClicked;

  lights({Key? key, required this.onLightClicked}) : super(key: key);

  @override
  State<lights> createState() => _lightsState();
}

class _lightsState extends State<lights> {
  bool isLightOn = false;

  void toggleLight() {
    setState(() {
      isLightOn = !isLightOn;
      widget.onLightClicked(isLightOn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLightOn ? Icons.lightbulb : Icons.lightbulb_outline,
        color: isLightOn ? Colors.amber : Colors.black,
        size: 50,
      ),
      onPressed: () {
        toggleLight();
      },
    );
  }
}