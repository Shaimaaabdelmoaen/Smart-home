import 'package:flutter/material.dart';
import 'package:smart_home1/UI/forgetPassword/resetPassword.dart';
import 'package:smart_home1/api/ApiManager.dart';

class OtpVerificationScreen extends StatefulWidget {
  static const routeName = 'enterCode';
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'sa3073@fayoum.edu.eg');
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  void _verifyOtp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    Map<String, dynamic> result = await APIManager.verifyOtp(
      _emailController.text,
      _otpController.text,
    );

    setState(() {
      _isLoading = false;
      if (result['status'] == true) {
        _successMessage = result['message'];
        Navigator.pushReplacementNamed(context, PasswordResetPage.routeName);
      } else {
        _errorMessage = result['message'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Enter Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            if (_isLoading) CircularProgressIndicator(),
            if (_errorMessage != null) Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            if (_successMessage != null) Text(_successMessage!, style: TextStyle(color: Colors.green)),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyOtp,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}