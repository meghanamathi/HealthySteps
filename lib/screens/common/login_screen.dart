import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../parents/parent_login_screen.dart';
import '../pregnant/pregnant_login_screen.dart';
import '../staff/staff_login_screen.dart';
import '../admin/admin_login_screen.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("select_role".tr(), style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                "choose_your_role".tr(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // 🟢 Role Dropdown
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
                onPressed: selectedRole.isEmpty ? null : navigateToRoleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                ),
                child: Text(
                  "continue".tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              const SizedBox(height: 20),

              // 🔗 Registration Link
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegistrationScreen()),
                  );
                },
                child: Text(
                  "don't_have_account".tr(),
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
