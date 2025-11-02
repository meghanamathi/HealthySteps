import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/api_service.dart';
import 'staff_dashboard.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key});

  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  final centerId = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  Future<void> loginStaff() async {
    setState(() => loading = true);

    final result = await ApiService.loginStaff(centerId.text, password.text);

    setState(() => loading = false);

    if (result != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => StaffDashboard(
            name: result['name'] ?? 'Staff',
            uniqueId: result['centerId'] ?? '',
            phone: result['phone'] ?? '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('invalid_credentials'.tr()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: Text('staff_login'.tr()),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 80, color: Colors.blue.shade700),
            const SizedBox(height: 20),
            Text(
              'login_to_continue'.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 40),

            // Center ID
            _buildField('center_id'.tr(), centerId),
            const SizedBox(height: 20),

            // Password
            _buildField('password'.tr(), password, obscure: true),
            const SizedBox(height: 30),

            // Login Button
            ElevatedButton.icon(
              onPressed: loading ? null : loginStaff,
              icon: const Icon(Icons.login, color: Colors.white),
              label: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('login'.tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
