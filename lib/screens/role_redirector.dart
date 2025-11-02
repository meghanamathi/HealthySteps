import 'package:flutter/material.dart';
import 'parents/parent_dashboard.dart';
import 'pregnant/pregnant_dashboard.dart';
import 'staff/staff_dashboard.dart';
import 'admin/admin_dashboard.dart';

class RoleRedirector extends StatelessWidget {
  final String role;
  final String name;
  final String uniqueId; // For Parent, it can be birthCertNo
  final String phone;

  const RoleRedirector({
    super.key,
    required this.role,
    required this.name,
    required this.uniqueId,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case "Parent":
        return ParentDashboard(
          name: name,
          birthCertNo: uniqueId, // use uniqueId field to pass birthCertNo
          phone: phone,
          uniqueId: uniqueId,
        );

      case "Pregnant Woman":
        return PregnantDashboard(
          name: name,
          uniqueId: uniqueId,
          phone: phone,
        );

      case "Staff":
        return StaffDashboard(
          name: name,
          uniqueId: uniqueId,
          phone: phone,
        );

      case "Admin":
        return AdminDashboard(
          name: name,
          uniqueId: uniqueId,
          phone: phone,
        );

      default:
        return const Scaffold(
          body: Center(
            child: Text(
              "Invalid Role",
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        );
    }
  }
}
