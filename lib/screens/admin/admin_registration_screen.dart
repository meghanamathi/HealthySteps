import 'package:flutter/material.dart';

class AdminRegistrationScreen extends StatefulWidget {
  const AdminRegistrationScreen({super.key});

  @override
  State<AdminRegistrationScreen> createState() => _AdminRegistrationScreenState();
}

class _AdminRegistrationScreenState extends State<AdminRegistrationScreen> {
  final uniqueId = TextEditingController();
  final password = TextEditingController();

  void register() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Admin Registered")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Registration"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: uniqueId, decoration: const InputDecoration(labelText: "Unique ID")),
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
