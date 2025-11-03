import 'dart:convert';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚙️ Base URL for backend
  static const String baseUrl = "http://10.10.29.218:5000/api";

  // ---------------------------------------------------------------------------
  // 🔹 COMMON AUTH (for general users if needed)
  // ---------------------------------------------------------------------------
  static Future<bool> register(
      String name,
      String email,
      String phone,
      String password,
      String role,
      String uniqueId,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'role': role,
          'uniqueId': uniqueId,
        }),
      );
      print("General Register Response: ${response.statusCode} - ${response.body}");
      return response.statusCode == 201;
    } catch (e) {
      print("General Register Error: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> login({
    required String uniqueId,
    required String password,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uniqueId': uniqueId,
          'password': password,
          'role': role,
        }),
      );
      print("Login Response ($role): ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Login Error ($role): $e");
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // 🔹 PARENT APIs
  // ---------------------------------------------------------------------------
  static Future<bool> registerParent({
    required String fatherName,
    required String motherName,
    required String fatherAadhar,
    required String motherAadhar,
    required String phone,
    required String password,
    required String childName,
    required String childGender,
    required String childDOB,
    required String birthCertificateNo,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/parents/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fatherName': fatherName,
          'motherName': motherName,
          'fatherAadhar': fatherAadhar,
          'motherAadhar': motherAadhar,
          'phoneNumber': phone,
          'password': password,
          'childName': childName,
          'childGender': childGender,
          'childDOB': childDOB,
          'birthCertificateNo': birthCertificateNo,
        }),
      );
      print("Parent Register: ${response.statusCode} - ${response.body}");
      return response.statusCode == 201;
    } catch (e) {
      print("Parent Register Error: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> loginParent(
      String birthCertificateNo,
      String password,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/parents/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'birthCertificateNo': birthCertificateNo,
          'password': password,
        }),
      );
      print("Parent Login: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Parent Login Error: $e");
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // 🔹 PREGNANT WOMAN APIs
  // ---------------------------------------------------------------------------
  static Future<bool> registerPregnantWoman({
    required String name,
    required String aadhar,
    required String phone,
    required String password,
    required String healthId,
    required String address,
    required String expectedDeliveryDate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pregnant/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'aadhar': aadhar,
          'phone': phone,
          'password': password,
          'healthId': healthId,
          'address': address,
          'expectedDeliveryDate': expectedDeliveryDate,
        }),
      );
      print("Pregnant Register: ${response.statusCode} - ${response.body}");
      return response.statusCode == 201;
    } catch (e) {
      print("Pregnant Register Error: $e");
      return false;
    }
  }


  static Future<Map<String, dynamic>?> loginPregnant(
      String uniqueId,
      String password,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pregnant/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uniqueId': uniqueId,
          'password': password,
        }),
      );
      print("Pregnant Login: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Pregnant Login Error: $e");
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // 🔹 STAFF APIs
  // ---------------------------------------------------------------------------
  static Future<bool> registerStaff({
    required String name,
    required String aadhar,
    required String phone,
    required String center,
    required String designation,
    required String centerId,
    required String password,
    required String district,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/staff/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'aadhar': aadhar,
          'phone': phone,
          'center': center,
          'designation': designation,
          'centerId': centerId,
          'password': password,
          'district': district,
        }),
      );
      print("Staff Register: ${response.statusCode} - ${response.body}");
      return response.statusCode == 201;
    } catch (e) {
      print("Staff Register Error: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> loginStaff(
      String centerId,
      String password,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/staff/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'centerId': centerId,
          'password': password,
        }),
      );
      print("Staff Login: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Staff Login Error: $e");
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // 🔹 ADMIN APIs
  // ---------------------------------------------------------------------------
  static Future<bool> registerAdmin({
    required String name,
    required String email,
    required String phone,
    required String aadhar,
    required String district,
    required String uniqueId,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'aadhar': aadhar,
          'district': district,
          'uniqueId': uniqueId,
          'password': password,
        }),
      );
      print("Admin Register: ${response.statusCode} - ${response.body}");
      return response.statusCode == 201;
    } catch (e) {
      print("Admin Register Error: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>?> loginAdmin(
      String uniqueId,
      String password,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uniqueId': uniqueId,
          'password': password,
        }),
      );
      print("Admin Login: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Admin Login Error: $e");
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // 🔹 ATTENDANCE
  // ---------------------------------------------------------------------------
  static Future<bool> markAttendance(bool isPresent) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/attendance'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'present': isPresent}),
      );
      print("Attendance: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print("Attendance Error: $e");
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // 🔹 GOODS
  // ---------------------------------------------------------------------------
  static Future<bool> confirmGoods(Map<String, bool> items) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/goods'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(items),
      );
      print("Goods Confirm: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print("Goods Error: $e");
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // 🔹 FEEDBACK
  // ---------------------------------------------------------------------------
  static Future<bool> submitFeedback(int rating, String feedback) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/feedback'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'rating': rating, 'feedback': feedback}),
      );
      print("Feedback: ${response.statusCode} - ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Feedback Error: $e");
      return false;
    }
  }
}
