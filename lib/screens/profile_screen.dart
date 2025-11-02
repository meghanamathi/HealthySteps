import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'common/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String role;
  final String id; // uniqueId / birthCertNo / centerId
  final String phone;
  final String email;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.role,
    required this.id,
    required this.phone,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Text('profile'.tr(), style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.green.shade300,
              child: const Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              role,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // 🧾 User Info Cards
            _buildInfoCard(Icons.badge, 'unique_id'.tr(), id),
            _buildInfoCard(Icons.phone, 'phone'.tr(), phone),
            _buildInfoCard(Icons.email, 'email'.tr(), email),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white),
              label: Text(
                'logout'.tr(),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF4CAF50), size: 30),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          value.isNotEmpty ? value : 'not_available'.tr(),
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ),
    );
  }
}
