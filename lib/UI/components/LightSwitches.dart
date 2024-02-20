import 'package:flutter/material.dart';

class LightSwitches extends StatelessWidget {
  final String nameSwitch;
  final  bool isSwitched;
  final ValueChanged<bool> onChange;
  const LightSwitches({Key? key, required this.nameSwitch , required this.isSwitched , required this.onChange}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Center(
      child: Padding(
        padding:  EdgeInsets.only(bottom: mediaQuery.size.height*.035),
        child: Container(
          width: double.infinity,
          height:mediaQuery.size.height*.08,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   SizedBox(width: 20,),
                  Icon(Icons.lightbulb, size: 25, color: isSwitched ? Colors.orange : Colors.indigo,),
                  const SizedBox(width: 20,),
                  Text(nameSwitch,style: TextStyle(color: Theme.of(context).secondaryHeaderColor),)
                ],
              ),
              Switch(
                value: isSwitched ,
                onChanged: onChange,
              ),

            ],
          ),
        ),
      ),
    );
  }
}