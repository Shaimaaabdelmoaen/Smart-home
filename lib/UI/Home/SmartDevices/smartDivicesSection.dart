import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/UI/Home/SmartDevices/smartDevicesBox.dart';
import '../../../api/ApiManager.dart';
import '../../../api/constant.dart';

class smartDevicesSection extends StatefulWidget {
  static const routeName = 'smartDevicesSection';

  @override
  State<smartDevicesSection> createState() => _smartDevicesSectionState();
}

class _smartDevicesSectionState extends State<smartDevicesSection> {
  List mySmartDevices = [
    ["Smart KH", "assets/icons/kitchen-hood.png", false],
    ["Smart AC", "assets/icons/air-conditioner.png", false],
    ["Smart TV", "assets/icons/smart-tv.png", false],
    ["Smart Fan", "assets/icons/fan.png", false],
  ];

  void powerSwitchChanged(bool newValue, int index) {
    setState(() {
      mySmartDevices[index][2] = newValue;
    });
    if (index == 0) {
      APIManager.toggleKH(newValue);
    } else if (index == 1) {
      APIManager.toggleAC(newValue);
    } else if (index == 2) {
      APIManager.toggleTV(newValue);
    } else if (index == 3) {
      APIManager.toggleKH(newValue);
    }
  }

  Future<void> toggleAC(bool newValue) async {
    await _toggleDevice(newValue, 'ac');
  }

  Future<void> toggleTV(bool newValue) async {
    await _toggleDevice(newValue, 'tv');
  }

  Future<void> toggleKH(bool newValue) async {
    await _toggleDevice(newValue, 'kh');
  }

  Future<void> togglefan(bool newValue) async {
    await _toggleDevice(newValue, 'ac');
  }

  Future<void> _toggleDevice(bool newValue, String device) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final String apiUrl = '${Constant.base_url}dev/$device';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final Map<String, dynamic> body = {
      "status": newValue ? "on" : "off",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode != 200) {
        print('Failed to toggle $device: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to toggle $device. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: mySmartDevices.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.5,
                  crossAxisSpacing: 40.0, // Space between items
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    powerOn: mySmartDevices[index][2],
                    onChange: (value) => powerSwitchChanged(value, index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
