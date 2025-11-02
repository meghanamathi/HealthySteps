import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../shared/feedback_screen.dart';
import '../shared/attendance_screen.dart';
import '../shared/goods_screen.dart';

class AdminDashboard extends StatelessWidget {
  final String name;
  final String uniqueId;
  final String phone;

  const AdminDashboard({
    super.key,
    required this.name,
    required this.uniqueId,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("${"welcome".tr()}, $name",
            style: const TextStyle(color: Colors.white)),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(context, Icons.feedback, "view_feedback".tr(),
              const FeedbackScreen()),
          _buildCard(context, Icons.calendar_today, "attendance_summary".tr(),
              const AttendanceScreen()),
          _buildCard(context, Icons.inventory, "goods_tracking".tr(),
              const GoodsScreen()),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.orange, size: 40),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
