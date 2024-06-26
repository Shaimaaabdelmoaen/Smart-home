import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpPage extends StatefulWidget {
  static const routeName='OtpPage';
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();

  Future<void> _verifyOtp(String otpCode) async {
    try {
      final response = await http.post(
        Uri.parse('https://4cda-154-178-203-69.ngrok-free.app/api/espotp'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'code': otpCode}),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('OTP verified successfully: $jsonData');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('OTP verified successfully!'),
        ));
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to verify OTP'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final otpCode = _otpController.text.trim();
                if (otpCode.isNotEmpty) {
                  await _verifyOtp(otpCode);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter OTP'),
                  ));
                }
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
