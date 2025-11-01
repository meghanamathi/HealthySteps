import 'package:flutter/material.dart';
import 'parent_registration_screen.dart';
import 'pregnant_registration_screen.dart';
import 'staff_registration_screen.dart';
import 'admin_registration_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text("Select Role"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _roleCard(context, "Parent", Icons.family_restroom, Colors.green, const ParentRegistrationScreen()),
            _roleCard(context, "Pregnant Woman", Icons.pregnant_woman, Colors.pink, const PregnantRegistrationScreen()),
            _roleCard(context, "Staff", Icons.school, Colors.blue, const StaffRegistrationScreen()),
            _roleCard(context, "Admin", Icons.admin_panel_settings, Colors.orange, const AdminRegistrationScreen()),
          ],
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
            Text(title, style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
