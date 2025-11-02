import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../parents/parent_registration_screen.dart';
import '../pregnant/pregnant_registration_screen.dart';
import '../staff/staff_registration_screen.dart';
import '../admin/admin_registration_screen.dart';

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
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        title: Text("select_role".tr(), style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                "register_as".tr(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 🔽 Role Dropdown
              DropdownButton<String>(
                value: selectedRole.isEmpty ? null : selectedRole,
                hint: Text("select_role".tr()),
                items: [
                  DropdownMenuItem(value: "Parent", child: Text("parent".tr())),
                  DropdownMenuItem(value: "Pregnant Woman", child: Text("pregnant_woman".tr())),
                  DropdownMenuItem(value: "Staff", child: Text("staff".tr())),
                  DropdownMenuItem(value: "Admin", child: Text("admin".tr())),
                ],
                onChanged: (v) => setState(() => selectedRole = v!),
              ),

              const SizedBox(height: 25),

              // ✅ Continue Button
              ElevatedButton(
                onPressed: selectedRole.isEmpty ? null : navigateToForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                ),
                child: Text(
                  "continue".tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
