import 'package:flutter/material.dart';
import 'pregnant_dashboard.dart';

class PregnantLoginScreen extends StatefulWidget {
  const PregnantLoginScreen({super.key});

  @override
  State<PregnantLoginScreen> createState() => _PregnantLoginScreenState();
}

class _PregnantLoginScreenState extends State<PregnantLoginScreen> {
  final uniqueIdController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PregnantDashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pregnant Woman Login"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: uniqueIdController,
              decoration: const InputDecoration(labelText: "Unique ID", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Login", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
