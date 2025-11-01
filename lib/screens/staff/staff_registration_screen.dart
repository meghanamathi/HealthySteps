import 'package:flutter/material.dart';

class StaffRegistrationScreen extends StatefulWidget {
  const StaffRegistrationScreen({super.key});

  @override
  State<StaffRegistrationScreen> createState() => _StaffRegistrationScreenState();
}

class _StaffRegistrationScreenState extends State<StaffRegistrationScreen> {
  final centerId = TextEditingController();
  final password = TextEditingController();

  void register() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Staff Registered")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Staff Registration"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: centerId, decoration: const InputDecoration(labelText: "Center ID")),
            const SizedBox(height: 20),
            TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: register, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("Register", style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
