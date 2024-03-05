import 'dart:convert';
import 'package:http/http.dart' as http;

class APIManager {
  static Future<String?> login(String email, String password) async {
    final String apiUrl = 'https://7ec1-154-178-220-91.ngrok-free.app/api/login';
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
    final String apiUrl = 'https://3f38-41-46-56-91.ngrok-free.app/api/door';
    final headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> body = {
      "status":"close",//newValue
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
  /*void sendOpenRequest() {
    toggleLamp('open');
  }

  void sendCloseRequest() {
    toggleLamp('close');
  }*/
}