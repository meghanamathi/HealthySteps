import 'package:flutter/material.dart';
import 'parent_registration_screen.dart';
import 'pregnant_registration_screen.dart';
import 'staff_registration_screen.dart';
import 'admin_registration_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String selectedRole = "";

  void navigateToForm() {
    if (selectedRole == "Parent") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ParentRegistrationScreen()));
    } else if (selectedRole == "Pregnant Woman") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const PregnantRegistrationScreen()));
    } else if (selectedRole == "Staff") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const StaffRegistrationScreen()));
    } else if (selectedRole == "Admin") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminRegistrationScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedRole.isEmpty ? null : navigateToForm,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Continue", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
