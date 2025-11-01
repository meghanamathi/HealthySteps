import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'goods_screen.dart';
import 'feedback_screen.dart';
import 'profile_screen.dart';

class ParentDashboard extends StatelessWidget {
  final String name;
  final String uniqueId;
  final String phone;

  const ParentDashboard({
    super.key,
    required this.name,
    required this.uniqueId,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Welcome, $name", style: const TextStyle(color: Colors.white)),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(context, Icons.calendar_today, "Attendance", const AttendanceScreen()),
          _buildCard(context, Icons.inventory, "Goods", const GoodsScreen()),
          _buildCard(context, Icons.feedback, "Feedback", const FeedbackScreen()),
          _buildCard(context, Icons.person, "Profile", const ProfileScreen()),
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
            Icon(icon, color: Colors.green, size: 40),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
