import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isPresent = false;
  bool loading = false;

  void markAttendance() async {
    setState(() => loading = true);
    final success = await ApiService.markAttendance(isPresent);
    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? 'Attendance marked!' : 'Failed to mark attendance')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("Today's Attendance", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Present'),
            value: isPresent,
            onChanged: (val) => setState(() => isPresent = val),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: loading ? null : markAttendance,
            child: loading ? const CircularProgressIndicator() : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
