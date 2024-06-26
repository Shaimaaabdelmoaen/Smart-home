import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class VideoStreamPage extends StatefulWidget {
  static const routeName='VideoStreamPage';
  final double angle;
  VideoStreamPage({required this.angle});
  @override
  _VideoStreamPageState createState() => _VideoStreamPageState();
}

class _VideoStreamPageState extends State<VideoStreamPage> {
  _launchURL() async {
    const url = 'http://192.168.1.8:8080/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.angle, // 270 degrees in radians
      child: IconButton(
        onPressed: _launchURL,
        icon: Icon(
          Icons.videocam_sharp,
          size: 35,
          color: Colors.black,
        ),
      ),
    );

  }
}