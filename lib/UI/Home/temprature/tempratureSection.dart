/*import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Temperature {
  final String day;
  final int temperature;

  Temperature(this.day, this.temperature);
}

class TemperatureChart extends StatelessWidget {
  static const String routeName='tempratureSection';
  final List<charts.Series<Temperature, String>> seriesList = [
    charts.Series<Temperature, String>(
      id: 'Temperature',
      domainFn: (Temperature temp, _) => temp.day,
      measureFn: (Temperature temp, _) => temp.temperature,
      data: [
        Temperature('Mon', 20),
        Temperature('Tue', 22),
        Temperature('Wed', 24),
        Temperature('Thu', 26),
        Temperature('Fri', 28),
        Temperature('Sat', 30),
        Temperature('Sun', 32),
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
        charts.SeriesLegend(),
      ],
    );
  }
}*/
/*import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart'as http;


class TemperatureChart extends StatefulWidget {
  static const String routeName='tempratureSection';
  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  List<TemperatureData> _chartData = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) => _fetchData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('https://api.example.com/temperature'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _chartData = data.map((item) => TemperatureData.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load temperature data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Chart'),
      ),
      body: _chartData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(
          minimum: 15,
          maximum: 35,
          interval: 5,
        ),
        series: <ChartSeries>[
          LineSeries<TemperatureData, DateTime>(
            dataSource: _chartData,
            xValueMapper: (TemperatureData data, _) => data.time,
            yValueMapper: (TemperatureData data, _) => data.temperature,
          ),
        ],
      ),
    );
  }
}

class TemperatureData {
  final DateTime time;
  final double temperature;

  TemperatureData(this.time, this.temperature);

  factory TemperatureData.fromJson(Map<String, dynamic> json) {
    return TemperatureData(
      DateTime.parse(json['time']),
      json['temperature'].toDouble(),
    );
  }
}*/
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureChart extends StatefulWidget {
  static const String routeName='tempratureSection';
  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  List<TemperatureData> _chartData = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _generateInitialData();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) => _updateData());
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
      _chartData.add(TemperatureData(
        currentTime.subtract(Duration(minutes: i * 10)),
        15 + random.nextDouble() * 20,
      ));
    }
    _chartData = _chartData.reversed.toList();
  }

  void _updateData() {
    final random = Random();
    setState(() {
      _chartData.add(TemperatureData(
        DateTime.now(),
        15 + random.nextDouble() * 20,
      ));
      if (_chartData.length > 20) {
        _chartData.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _chartData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
            height: 240,
            child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                      labelStyle: TextStyle(fontSize: 18)
                    ),
                    primaryYAxis: NumericAxis(
                        minimum: 15,
                        maximum: 35,
                        interval: 5,
                      labelStyle: TextStyle(fontSize: 18)
                    ),
                    series: <ChartSeries>[
                      LineSeries<TemperatureData, DateTime>(
                        color: Theme.of(context).primaryColor,
                        dataSource: _chartData,
                        xValueMapper: (TemperatureData data, _) => data.time,
                        yValueMapper: (TemperatureData data, _) => data.temperature,
                      ),
                      AreaSeries<TemperatureData, DateTime>(
                        dataSource: _chartData,
                        xValueMapper: (TemperatureData data, _) => data.time,
                        yValueMapper: (TemperatureData data, _) => data.temperature,
                        color: Theme.of(context).primaryColor.withOpacity(0.8), // Fill color
                      ),
                    ],
                  ),
          );

  }
}

class TemperatureData {
  final DateTime time;
  final double temperature;

  TemperatureData(this.time, this.temperature);
}
/*import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureChart extends StatefulWidget {
  static const String routeName='tempratureSection';
  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  List<TemperatureData> _chartData = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _generateInitialData();
    _timer = Timer.periodic(Duration(minutes: 10), (timer) => _updateData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _generateInitialData() {
    final currentTime = DateTime.now();
    final random = Random();
    for (int i = 0; i < 144; i++) {
      _chartData.add(TemperatureData(
        currentTime.subtract(Duration(minutes: i * 10)),
        15 + random.nextDouble() * 20,
      ));
    }
    _chartData = _chartData.reversed.toList();
  }

  void _updateData() {
    final random = Random();
    setState(() {
      _chartData.add(TemperatureData(
        DateTime.now(),
        15 + random.nextDouble() * 20,
      ));
      if (_chartData.length > 144) {
        _chartData.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final chartHeight = mediaQuery.size.height * 0.5;
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Chart'),
      ),
      body: _chartData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          intervalType: DateTimeIntervalType.hours,
          interval: 1,
          dateFormat: DateFormat.Hm(),
        ),
        primaryYAxis: NumericAxis(
          minimum: 15,
          maximum: 35,
          interval: 5,
        ),
        series: <ChartSeries>[
          LineSeries<TemperatureData, DateTime>(
            dataSource: _chartData,
            xValueMapper: (TemperatureData data, _) => data.time,
            yValueMapper: (TemperatureData data, _) => data.temperature,
          ),
        ],
      ),
    );
  }
}

class TemperatureData {
  final DateTime time;
  final double temperature;

  TemperatureData(this.time, this.temperature);
}*/
