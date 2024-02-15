import 'package:flutter/material.dart';

class LightSwitches extends StatefulWidget {
  final String nameSwitch;
  //final  bool isSwitched=false;
  const LightSwitches({Key? key, required this.nameSwitch}) : super(key: key);

  @override
  _LightSwitchesState createState() => _LightSwitchesState();
}

class _LightSwitchesState extends State<LightSwitches> {
  bool isSwitched=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height:50,
        decoration: BoxDecoration(
          color: Colors.white54,
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
                Icon(Icons.lightbulb, size: 25, color: isSwitched ? Colors.orange : Colors.indigo,),
                SizedBox(width: 10,),
                Text(widget.nameSwitch),
              ],
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
//Image(image: AssetImage( isSwitched? "assets/on.png" : "assets/off.png")),