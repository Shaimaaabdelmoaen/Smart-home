/*import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class IPWebcamScreen extends StatefulWidget {
  static const routeName='IPWebcamScreen';
  @override
  _IPWebcamScreenState createState() => _IPWebcamScreenState();
}

class _IPWebcamScreenState extends State<IPWebcamScreen> {
  late VlcPlayerController _vlcViewController;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _vlcViewController = VlcPlayerController.network(
      'rtsp://192.168.1.8:8080/h264.sdp',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }


  @override
  void dispose() {
    _vlcViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Webcam Stream'),
      ),
      body: Center(
        child: VlcPlayer(
          controller: _vlcViewController,
          aspectRatio: 16 / 9,
          placeholder:
          Center(
              child: CircularProgressIndicator()
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_isPlaying) {
              _vlcViewController.pause();
            } else {
              _vlcViewController.play();
            }
            _isPlaying = !_isPlaying;
          });
        },
        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class IPWebcamScreen extends StatefulWidget {
  static const routeName='IPWebcamScreen';
  @override
  _IPWebcamScreenState createState() => _IPWebcamScreenState();
}

class _IPWebcamScreenState extends State<IPWebcamScreen> {
  late VlcPlayerController _vlcViewController;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _vlcViewController = VlcPlayerController.network(
      'rtsp://192.168.1.8:8080/h264.sdp',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    _vlcViewController.addListener(() {
      final vlcValue = _vlcViewController.value;
      print('Playback State: ${vlcValue.playingState}');
      if (vlcValue.isBuffering) {
        print('Buffering...');
      } else if (vlcValue.isPlaying) {
        print('Playing...');
      } else if (vlcValue.hasError) {
        print('Error: ${vlcValue.errorDescription}');
      }
    });
  }

  @override
  void dispose() {
    _vlcViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Webcam Stream'),
      ),
      body: Center(
        child: VlcPlayer(
          controller: _vlcViewController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_isPlaying) {
              _vlcViewController.pause();
            } else {
              _vlcViewController.play();
            }
            _isPlaying = !_isPlaying;
          });
        },
        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}