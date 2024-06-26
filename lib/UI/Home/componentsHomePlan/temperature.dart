import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/constant.dart';

class temperature extends StatefulWidget {
  @override
  _temperatureState createState() => _temperatureState();
}

class _temperatureState extends State<temperature> {
  late String _temperature;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchTemperature();
    _timer = Timer.periodic(Duration(seconds: 100), (timer) => _fetchTemperature());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchTemperature() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return;
    }
    final response = await http.post(Uri.parse('${Constant.base_url}temp'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _temperature = jsonData['value'];
      });
    } else {
      throw Exception('Failed to load temperature data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Temperature'),
            content: Text('$_temperature',style: TextStyle(color: Colors.red,fontSize: 30,),textAlign: TextAlign.center,),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK', style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
              ),
            ],
          ),
        );
      },
      icon: Icon(Icons.thermostat, size: 40, color: Colors.red),
    );
  }
}
