import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../parents/parent_registration_screen.dart';
import '../pregnant/pregnant_registration_screen.dart';
import '../staff/staff_registration_screen.dart';
import '../admin/admin_registration_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text("select_role".tr(), style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _roleCard(context, "parent".tr(), Icons.family_restroom, Colors.green, const ParentRegistrationScreen()),
              _roleCard(context, "pregnant_woman".tr(), Icons.pregnant_woman, Colors.pink, const PregnantRegistrationScreen()),
              _roleCard(context, "staff".tr(), Icons.school, Colors.blue, const StaffRegistrationScreen()),
              _roleCard(context, "admin".tr(), Icons.admin_panel_settings, Colors.orange, const AdminRegistrationScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleCard(BuildContext context, String title, IconData icon, Color color, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
