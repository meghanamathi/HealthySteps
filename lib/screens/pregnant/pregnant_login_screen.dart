import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/api_service.dart';
import 'pregnant_dashboard.dart';

class PregnantLoginScreen extends StatefulWidget {
  const PregnantLoginScreen({super.key});

  @override
  State<PregnantLoginScreen> createState() => _PregnantLoginScreenState();
}

class _PregnantLoginScreenState extends State<PregnantLoginScreen> {
  final uniqueId = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  Future<void> loginPregnant() async {
    setState(() => loading = true);
    final result = await ApiService.loginPregnant(uniqueId.text, password.text);
    setState(() => loading = false);

    if (result != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PregnantDashboard(
            name: result['name'] ?? 'User',
            uniqueId: result['uniqueId'] ?? '',
            phone: result['phone'] ?? '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("login_failed".tr()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pregnant_login".tr()),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildField("unique_id".tr(), uniqueId),
            const SizedBox(height: 20),
            _buildField("password".tr(), password, obscure: true),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: loading ? null : loginPregnant,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text("login".tr(), style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool obscure = false}) {
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
