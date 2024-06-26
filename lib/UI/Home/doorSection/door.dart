import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/api/ApiManager.dart';

class Door extends StatefulWidget {
  final ValueChanged<bool> onChange;

  const Door({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  _DoorState createState() => _DoorState();
}

class _DoorState extends State<Door> {
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
              bool newState = !isOpen;
              widget.onChange(newState);
              setState(() {
                isOpen = newState;
              });
              APIManager.toggleDoor(isOpen);
            },
            child: Text(isOpen ? 'Close' : 'Open'),
          ),
        ],
      ),
    );
  }
}
