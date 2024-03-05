import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrint extends StatefulWidget {
  static const routeName = 'fingerPrint';

  const FingerPrint({Key? key}) : super(key: key);

  @override
  State<FingerPrint> createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  Color authenticateColor = Colors.white;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
        _supportState = isSupported;
      }),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Subscribe to open Door',
        androidAuthStrings: AndroidAuthMessages(
          biometricHint: 'Custom biometric hint message',
          signInTitle: 'Custom sign in title',
          cancelButton: 'Custom cancel button',
        ),
      );
      if (authenticated) {
        setState(() {
          authenticateColor = Colors.green;
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        authenticateColor = Colors.red;
      });
      print("Authenticate exception : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_supportState)
            Text(
              'This Device is Support Biometric Sensors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900,),
            )
          else
            Text(
              'This Device is NOT Support Biometric Sensors',
              style: TextStyle(
                fontSize: 40,
                color: Color(0xff101010),
              ),
            ),
          Divider(
            height: 100,
          ),
          ElevatedButton(
            onPressed: _authenticate,
            style: ElevatedButton.styleFrom(backgroundColor: authenticateColor),
            child: Text(
              'Authenticate to Open door',
              style: TextStyle(color: Color(0xff101010)),
            ),
          ),
        ],
      ),
    );
  }
}