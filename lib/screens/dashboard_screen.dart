import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'shared/attendance_screen.dart';
import 'shared/goods_screen.dart';
import 'shared/feedback_screen.dart';
import 'profile_screen.dart';
import 'common/login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Text('dashboard'.tr(), style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          _buildCard(context, Icons.event_available, 'attendance', const AttendanceScreen()),
          _buildCard(context, Icons.shopping_basket, 'goods', const GoodsScreen()),
          _buildCard(context, Icons.star_rate, 'feedback', const FeedbackScreen()),
          _buildCard(context, Icons.person, 'profile', const ProfileScreen(name: '', role: '', id: '', phone: '', email: '',)),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: const Color(0xFF4CAF50)),
            const SizedBox(height: 12),
            Text(
              label.tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
