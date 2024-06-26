import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../api/constant.dart';

class TemperatureChart extends StatefulWidget {
  static const String routeName = 'temperatureSection';

  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  List<Map<String, dynamic>> _chartData = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _generateInitialData();
    _timer = Timer.periodic(Duration(seconds: 100000000000000000), (timer) => _updateData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _generateInitialData() {
    final currentTime = DateTime.now();
    final random = Random();
    for (int i = 0; i < 20; i++) {
      _chartData.add({'time': currentTime.subtract(Duration(minutes: i * 10)), 'temperature': 15 + random.nextDouble() * 20});
    }
    _chartData = _chartData.reversed.toList();
  }

  Future<void> _updateData() async {
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
      final temperature = double.parse(jsonData['value']);
      final currentTime = DateTime.parse('${DateTime.now().toIso8601String().substring(0, 10)} ${jsonData['time']}');
      setState(() {
        _chartData.add({'time': currentTime, 'temperature': temperature});
        if (_chartData.length > 20) {
          _chartData.removeAt(0);
        }
      }
      );
    } else {
      throw Exception('Failed to load temperature data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _chartData.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Container(
      height: 240,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(labelStyle: TextStyle(fontSize: 18)),
        primaryYAxis: NumericAxis(
          minimum: 20,
          maximum: 40,
          interval: 5,
          labelStyle: TextStyle(fontSize: 18),
        ),
        series: <ChartSeries>[
          LineSeries<Map<String, dynamic>, DateTime>(
            color: Theme.of(context).primaryColor,
            dataSource: _chartData,
            xValueMapper: (data, _) => data['time'],
            yValueMapper: (data, _) => data['temperature'],
          ),
          AreaSeries<Map<String, dynamic>, DateTime>(
            dataSource: _chartData,
            xValueMapper: (data, _) => data['time'],
            yValueMapper: (data, _) => data['temperature'],
            color: Theme.of(context).primaryColor.withOpacity(0.8), // Fill color
          ),
        ],
      ),
    );
  }
}

