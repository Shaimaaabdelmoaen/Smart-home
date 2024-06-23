/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class lights extends StatefulWidget {
  final Function(bool) onLightClicked;
  bool isLightOn = false;
  lights({Key? key, required this.onLightClicked, this.isLightOn = false}) : super(key: key);

  @override
  State<lights> createState() => _lightsState();
}

class _lightsState extends State<lights> {


  void toggleLight() {
    setState(() {
      widget.isLightOn = !widget.isLightOn;
      widget.onLightClicked(widget.isLightOn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isLightOn ? Icons.lightbulb : Icons.lightbulb_outline,
        color: widget.isLightOn ? Colors.amber : Colors.black,
        size: 50,
      ),
      onPressed: () {
        toggleLight();
      },
    );
  }
}*/
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_home1/api/ApiManager.dart';

class lights extends StatefulWidget {
  final Function(bool) onLightClicked;
  bool isLightOn = false;

  lights({Key? key, required this.onLightClicked, this.isLightOn = false}) : super(key: key);

  @override
  State<lights> createState() => _lightsState();
}

class _lightsState extends State<lights> {
  void toggleLight() async {
    try {
      bool newValue = !widget.isLightOn;
      await APIManager.toggleLamp(newValue);
      setState(() {
        widget.isLightOn = newValue;
        widget.onLightClicked(widget.isLightOn);
      });
    } catch (e) {
      print('Error: $e');
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isLightOn ? Icons.lightbulb : Icons.lightbulb_outline,
        color: widget.isLightOn ? Colors.amber : Colors.black,
        size: 50,
      ),
      onPressed: () {
        toggleLight();
      },
    );
  }
}
