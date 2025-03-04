import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../api/ApiManager.dart';

class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;
  final bool powerOn;
  final ValueChanged<bool> onChange;

  SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.powerOn,
    required this.onChange,
  });

  Future<void> _toggleDevice(String device, bool newValue) async {
    try {
      await APIManager.toggleDevice(device, newValue);
      onChange(newValue);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: powerOn ? Theme.of(context).primaryColor.withOpacity(.8) : Color.fromARGB(54, 164, 167, 109),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              iconPath,
              height: 65,
              color: powerOn ? Colors.white : Theme.of(context).primaryColor,
            ),
          ),
          // smart device name + switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    smartDeviceName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: powerOn ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: pi / 2,
                child: CupertinoSwitch(
                  value: powerOn,
                  onChanged: (value) {
                    _toggleDevice(smartDeviceName.toLowerCase().replaceAll(' ', '_'), value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}