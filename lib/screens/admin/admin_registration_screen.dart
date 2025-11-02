import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../admin/admin_dashboard.dart';

class AdminRegistrationScreen extends StatefulWidget {
  const AdminRegistrationScreen({super.key});

  @override
  State<AdminRegistrationScreen> createState() => _AdminRegistrationScreenState();
}

class _AdminRegistrationScreenState extends State<AdminRegistrationScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final aadhar = TextEditingController();
  final district = TextEditingController();
  final uniqueId = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  Future<void> registerAdmin() async {
    if (name.text.isEmpty ||
        email.text.isEmpty ||
        phone.text.isEmpty ||
        aadhar.text.isEmpty ||
        district.text.isEmpty ||
        uniqueId.text.isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => loading = true);
    final success = await ApiService.registerAdmin(
      name: name.text,
      email: email.text,
      phone: phone.text,
      aadhar: aadhar.text,
      district: district.text,
      uniqueId: uniqueId.text,
      password: password.text,
    );
    setState(() => loading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AdminDashboard(
            name: name.text,
            uniqueId: uniqueId.text,
            phone: phone.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration failed!")),
      );
    }
  }

  Widget _buildField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Registration"), backgroundColor: Colors.deepPurple),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildField("Name", name),
            _buildField("Email", email),
            _buildField("Phone Number", phone),
            _buildField("Aadhar Number", aadhar),
            _buildField("District", district),
            _buildField("Unique ID", uniqueId),
            _buildField("Password", password, isPassword: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : registerAdmin,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Register", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
