import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

class VideoStreamPage extends StatefulWidget {
  static const routeName='VideoStreamPage';
  final double angle;
  VideoStreamPage({required this.angle});
  @override
  _VideoStreamPageState createState() => _VideoStreamPageState();
}

class _VideoStreamPageState extends State<VideoStreamPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://your-video-url/stream.m3u8',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showVideoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Video'),
          content: Container(
            width: double.infinity,
            height: 200,
            child: FutureBuilder<void>(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _controller.pause();
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ],
        );
      },
    );
    _controller.play();
  }
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.angle, // 270 degrees in radians
      child: IconButton(
        onPressed: _showVideoDialog,
        icon: Icon(
          Icons.videocam_sharp,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}