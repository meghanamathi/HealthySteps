import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../staff/staff_dashboard.dart';

class StaffRegistrationScreen extends StatefulWidget {
  const StaffRegistrationScreen({super.key});

  @override
  State<StaffRegistrationScreen> createState() => _StaffRegistrationScreenState();
}

class _StaffRegistrationScreenState extends State<StaffRegistrationScreen> {
  final name = TextEditingController();
  final aadhar = TextEditingController();
  final phone = TextEditingController();
  final center = TextEditingController();
  final designation = TextEditingController();
  final centerId = TextEditingController();
  final password = TextEditingController();
  final district = TextEditingController();
  bool loading = false;

  Future<void> registerStaff() async {
    if (name.text.isEmpty ||
        aadhar.text.isEmpty ||
        phone.text.isEmpty ||
        center.text.isEmpty ||
        designation.text.isEmpty ||
        centerId.text.isEmpty ||
        district.text.isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() => loading = true);
    final success = await ApiService.registerStaff(
      name: name.text,
      aadhar: aadhar.text,
      phone: phone.text,
      center: center.text,
      designation: designation.text,
      centerId: centerId.text,
      password: password.text,
      district: district.text,
    );
    setState(() => loading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => StaffDashboard(
            name: name.text,
            uniqueId: centerId.text,
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
      appBar: AppBar(title: const Text("Staff Registration"), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildField("Name", name),
            _buildField("Aadhar Number", aadhar),
            _buildField("Phone Number", phone),
            _buildField("District", district),
            _buildField("Center Name", center),
            _buildField("Designation", designation),
            _buildField("Center ID", centerId),
            _buildField("Password", password, isPassword: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : registerStaff,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
