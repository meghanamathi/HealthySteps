import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../shared/feedback_screen.dart';
import '../shared/attendance_screen.dart';
import '../shared/goods_screen.dart';

class ParentDashboard extends StatelessWidget {
  final String name;
  final String uniqueId;
  final String phone;

  const ParentDashboard({
    super.key,
    required this.name,
    required this.uniqueId,
    required this.phone, required String birthCertNo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        title: Text(
          '${'welcome'.tr()}, $name',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(context, Icons.child_care, 'attendance'.tr(), const AttendanceScreen()),
          _buildCard(context, Icons.feedback, 'feedback'.tr(), const FeedbackScreen()),
          _buildCard(context, Icons.inventory, 'goods_confirmation'.tr(), const GoodsScreen()),
          _buildCard(context, Icons.person, 'profile'.tr(), _buildProfile(context)),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        if (page is Widget) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        }
      },
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.green),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Profile info section
  Widget _buildProfile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profile'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${'name'.tr()}: $name', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('${'unique_id'.tr()}: $uniqueId', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('${'phone'.tr()}: $phone', style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
