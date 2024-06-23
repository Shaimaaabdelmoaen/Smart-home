import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home1/api/constant.dart';

class APIManager {
  static Future<String?> login(String email, String password) async {
    final String apiUrl = '${Constant.base_url}login';
    final Map<String, dynamic> formData = {
      'email': email.trim(),
      'password': password.trim(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: formData,
      );
      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];
        return token;
      } else {
        throw Exception('Invalid');
      }
    } catch (e) {
      throw Exception('An error occurred. Please try again later.');
    }
  }
  static Future<void> toggleLamp(bool newValue) async {
    final String apiUrl = '${Constant.base_url}door';
    final headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> body = {
      "status":newValue?"open" : "close",
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(body),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to toggle lamp: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred. Please try again later.');
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    final url = Uri.parse('${Constant.base_url}verify-otp-mobile');
    final client = http.Client();

    try {
      http.Response response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      if (response.statusCode == 302 || response.statusCode == 307) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          response = await client.post(
            Uri.parse(redirectUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'otp': otp}),
          );
        } else {
          return {'status': false, 'message': 'Failed to follow redirect'};
        }
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          // Store the token in shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', responseData['token']);
        }
        return responseData;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return {'status': false, 'message': 'Failed to verify OTP'};
      }
    } finally {
      client.close();
    }
  }
  /*void sendOpenRequest() {
    toggleLamp('open');
  }

  void sendCloseRequest() {
    toggleLamp('close');
  }*/
}