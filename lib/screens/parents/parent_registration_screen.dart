import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../parents/parent_dashboard.dart';

class ParentRegistrationScreen extends StatefulWidget {
  const ParentRegistrationScreen({super.key});

  @override
  State<ParentRegistrationScreen> createState() => _ParentRegistrationScreenState();
}

class _ParentRegistrationScreenState extends State<ParentRegistrationScreen> {
  final fatherName = TextEditingController();
  final motherName = TextEditingController();
  final fatherAadhar = TextEditingController();
  final motherAadhar = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final childName = TextEditingController();
  final birthCert = TextEditingController();
  String? childGender;
  DateTime? selectedDOB;

  bool loading = false;

  Future<void> _selectDOB(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2021),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => selectedDOB = picked);
  }

  Future<void> registerParent() async {
    if (fatherName.text.isEmpty ||
        motherName.text.isEmpty ||
        fatherAadhar.text.isEmpty ||
        motherAadhar.text.isEmpty ||
        phone.text.isEmpty ||
        password.text.isEmpty ||
        childName.text.isEmpty ||
        childGender == null ||
        selectedDOB == null ||
        birthCert.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => loading = true);
    final success = await ApiService.registerParent(
      fatherName: fatherName.text,
      motherName: motherName.text,
      fatherAadhar: fatherAadhar.text,
      motherAadhar: motherAadhar.text,
      phone: phone.text,
      password: password.text,
      childName: childName.text,
      childGender: childGender!,
      childDOB: selectedDOB!.toIso8601String(),
      birthCertificateNo: birthCert.text,
    );
    setState(() => loading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ParentDashboard(
            name: fatherName.text,
            uniqueId: birthCert.text,
            phone: phone.text,
            birthCertNo: birthCert.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Registration failed!")));
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
      appBar: AppBar(title: const Text("Parent Registration"), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildField("Father Name", fatherName),
            _buildField("Mother Name", motherName),
            _buildField("Father Aadhar", fatherAadhar),
            _buildField("Mother Aadhar", motherAadhar),
            _buildField("Phone Number", phone),
            _buildField("Password", password, isPassword: true),
            _buildField("Child Name", childName),
            DropdownButtonFormField<String>(
              value: childGender,
              items: const [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (v) => setState(() => childGender = v),
              decoration: InputDecoration(
                labelText: "Child Gender",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _selectDOB(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: selectedDOB == null
                        ? ''
                        : "${selectedDOB!.day}-${selectedDOB!.month}-${selectedDOB!.year}",
                  ),
                  decoration: InputDecoration(
                    labelText: "Child DOB",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildField("Birth Certificate No", birthCert),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : registerParent,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
