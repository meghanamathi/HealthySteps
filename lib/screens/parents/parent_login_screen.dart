import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/api_service.dart';
import 'parent_dashboard.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({super.key});

  @override
  State<ParentLoginScreen> createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> {
  final birthCertNo = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  Future<void> loginParent() async {
    setState(() => loading = true);
    final result = await ApiService.loginParent(birthCertNo.text, password.text);
    setState(() => loading = false);

    if (result != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ParentDashboard(
            name: result['name'] ?? 'Parent',
            uniqueId: result['birthCertNo'] ?? '', // Use as uniqueId
            phone: result['phone'] ?? '', birthCertNo: '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("invalid_credentials".tr()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('parent_login'.tr()), backgroundColor: Colors.purple),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildField("birth_certificate".tr(), birthCertNo),
            const SizedBox(height: 20),
            _buildField("password".tr(), password, obscure: true),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: loading ? null : loginParent,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
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
