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
}**/
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
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VlcPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      'rtsp://viewer:aeDoPhiucees3gohshie@173.249.14.110:27954/axis-media/media.amp?videocodec=h264&fps=15&audio=1&resolution=640x480',
      hwAcc: HwAcc.FULL,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IPWebcamScreen extends StatefulWidget{
  static const routeName='IPWebcamScreen';

  @override
  State<IPWebcamScreen> createState() => _IPWebcamScreenState();
}

class _IPWebcamScreenState extends State<IPWebcamScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: ElevatedButton(
         onPressed: _launchURL,
         child: Text('Open URL'),
       ),
     ),
   );
  }

  _launchURL() async {
    const url = 'http://192.168.1.8:8080/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}