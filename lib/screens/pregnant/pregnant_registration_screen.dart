// lib/pregnant/pregnant_registration_screen.dart
import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../pregnant/pregnant_dashboard.dart';

class PregnantRegistrationScreen extends StatefulWidget {
  const PregnantRegistrationScreen({super.key});

  @override
  State<PregnantRegistrationScreen> createState() =>
      _PregnantRegistrationScreenState();
}

class _PregnantRegistrationScreenState
    extends State<PregnantRegistrationScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController aadhar = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController healthId = TextEditingController();
  final TextEditingController address = TextEditingController();
  DateTime? expectedDeliveryDate;
  bool loading = false;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) setState(() => expectedDeliveryDate = picked);
  }

  Future<void> registerPregnant() async {
    if (name.text.isEmpty ||
        aadhar.text.isEmpty ||
        phone.text.isEmpty ||
        password.text.isEmpty ||
        healthId.text.isEmpty ||
        address.text.isEmpty ||
        expectedDeliveryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => loading = true);

    // <-- CORRECT call: only named parameters, no duplicate 'name' param
    final success = await ApiService.registerPregnantWoman(
      name: name.text,
      aadhar: aadhar.text,
      phone: phone.text,
      password: password.text,
      healthId: healthId.text,
      address: address.text,
      expectedDeliveryDate: expectedDeliveryDate!.toIso8601String(),
    );

    setState(() => loading = false);

    if (success) {
      // After successful registration go to pregnant dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PregnantDashboard(
            name: name.text,
            uniqueId: healthId.text,
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

  Widget _buildField(String label, TextEditingController controller,
      {bool isPassword = false}) {
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
  void dispose() {
    name.dispose();
    aadhar.dispose();
    phone.dispose();
    password.dispose();
    healthId.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Pregnant Woman Registration"), backgroundColor: Colors.pink),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildField("Name", name),
            _buildField("Aadhar Number", aadhar),
            _buildField("Phone Number", phone),
            _buildField("Password", password, isPassword: true),
            _buildField("Health ID", healthId),
            _buildField("Address", address),
            const SizedBox(height: 10),

            // Date picker field
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: expectedDeliveryDate == null
                        ? ''
                        : "${expectedDeliveryDate!.day}-${expectedDeliveryDate!.month}-${expectedDeliveryDate!.year}",
                  ),
                  decoration: InputDecoration(
                    labelText: "Expected Delivery Date",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : registerPregnant,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: loading
                  ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
                  : const Text("Register", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}