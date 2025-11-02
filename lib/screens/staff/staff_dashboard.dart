import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../shared/attendance_screen.dart';
import '../shared/goods_screen.dart';
import '../shared/feedback_screen.dart';

class StaffDashboard extends StatelessWidget {
  final String name;
  final String uniqueId;
  final String phone;

  const StaffDashboard({
    super.key,
    required this.name,
    required this.uniqueId,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'welcome_user'.tr(args: [name]),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(context, Icons.calendar_today, 'mark_attendance'.tr(), const AttendanceScreen()),
          _buildCard(context, Icons.inventory, 'confirm_goods'.tr(), const GoodsScreen()),
          _buildCard(context, Icons.feedback, 'give_feedback'.tr(), const FeedbackScreen()),
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
            Icon(icon, color: Colors.blue, size: 40),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
