import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../shared/feedback_screen.dart';

class PregnantDashboard extends StatelessWidget {
  final String name;
  final String uniqueId;
  final String phone;

  const PregnantDashboard({
    super.key,
    required this.name,
    required this.uniqueId,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "${"welcome".tr()}, $name",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.feedback),
          label: Text("give_feedback".tr()),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FeedbackScreen()),
            );
          },
        ),
      ),
    );
  }
}
