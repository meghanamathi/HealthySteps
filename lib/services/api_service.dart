import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "http://10.0.2.2:5000/api"; // Use 10.0.2.2 for Android emulator

  static Future<bool> login(String uniqueId, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uniqueId': uniqueId, 'password': password}),
    );
    return res.statusCode == 200;
  }

  static Future<void> register(String name, String email, String phone, String uniqueId, String password, String role) async {
    await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'phone': phone, 'uniqueId': uniqueId, 'password': password, 'role': role}),
    );
  }

  static Future<bool> markAttendance(bool isPresent) async {
    final res = await http.post(
      Uri.parse('$baseUrl/attendance'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'present': isPresent}),
    );
    return res.statusCode == 200;
  }

  static Future<bool> confirmGoods(Map<String, bool> goods) async {
    final res = await http.post(
      Uri.parse('$baseUrl/goods'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'goods': goods}),
    );
    return res.statusCode == 200;
  }

  static Future<bool> submitFeedback(int rating, String comment) async {
    final res = await http.post(
      Uri.parse('$baseUrl/feedback'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'rating': rating, 'comment': comment}),
    );
    return res.statusCode == 200;
  }
}
