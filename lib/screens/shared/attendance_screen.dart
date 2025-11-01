import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/api_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isPresent = false;
  bool isLoading = false;

  Future<void> markAttendance() async {
    setState(() => isLoading = true);
    final success = await ApiService.markAttendance(isPresent);
    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? Colors.green : Colors.red,
        content: Text(
          success
              ? 'attendance_marked'.tr()
              : 'attendance_failed'.tr(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Text('attendance'.tr(),
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Icon(Icons.child_care,
                size: 80, color: const Color(0xFF2E7D32).withOpacity(0.9)),
            const SizedBox(height: 20),
            Text(
              'mark_child_attendance'.tr(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Attendance toggle
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('child_present'.tr(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    Switch(
                      value: isPresent,
                      onChanged: (value) {
                        setState(() => isPresent = value);
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Submit button
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              label: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('submit'.tr(),
                  style:
                  const TextStyle(fontSize: 18, color: Colors.white)),
              onPressed: isLoading ? null : markAttendance,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding:
                const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
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
}
