import 'dart:convert';
import 'package:http/http.dart' as http;

class APIManager {
  static Future<String?> login(String email, String password) async {
    final String apiUrl = 'https://75b9-41-46-40-131.ngrok-free.app/api/login';
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
}