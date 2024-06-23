import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/api/ApiManager.dart';

class door extends StatefulWidget {
  @override
  _DoorState createState() => _DoorState();
}

class _DoorState extends State<door> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            isOpen ? 'assets/icons/open-door-icon.png' : 'assets/icons/closed-door-icon.png',
            height: MediaQuery.of(context).size.height / 6.3,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () async {
              try {
                isOpen = !isOpen;
                await APIManager.toggleLamp(isOpen);
              } catch (e) {
                throw Exception('An error occurred. Please try again later.');
              }
              setState(() {});
            },
            child: Text(isOpen ? 'Close' : 'Open'),
          ),
        ],
      ),
    );
  }

// Your toggleLamp function here
}