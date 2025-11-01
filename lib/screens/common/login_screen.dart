import 'package:flutter/material.dart';
import 'parents/parent_login_screen.dart';
import 'pregnant/pregnant_login_screen.dart';
import 'staff/staff_login_screen.dart';
import 'admin/admin_login_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = "";

  void navigateToRoleLogin() {
    if (selectedRole == "Parent") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ParentLoginScreen()));
    } else if (selectedRole == "Pregnant Woman") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const PregnantLoginScreen()));
    } else if (selectedRole == "Staff") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const StaffLoginScreen()));
    } else if (selectedRole == "Admin") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(title: const Text("Select Role"), backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedRole.isEmpty ? null : selectedRole,
              hint: const Text("Select Role"),
              items: const [
                DropdownMenuItem(value: "Parent", child: Text("Parent")),
                DropdownMenuItem(value: "Pregnant Woman", child: Text("Pregnant Woman")),
                DropdownMenuItem(value: "Staff", child: Text("Staff")),
                DropdownMenuItem(value: "Admin", child: Text("Admin")),
              ],
              onChanged: (v) => setState(() => selectedRole = v!),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: selectedRole.isEmpty ? null : navigateToRoleLogin,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Continue", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistrationScreen()));
              },
              child: const Text("Don’t have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
