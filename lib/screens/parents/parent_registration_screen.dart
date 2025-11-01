import 'package:flutter/material.dart';

class ParentRegistrationScreen extends StatefulWidget {
  const ParentRegistrationScreen({super.key});

  @override
  State<ParentRegistrationScreen> createState() => _ParentRegistrationScreenState();
}

class _ParentRegistrationScreenState extends State<ParentRegistrationScreen> {
  final birthCert = TextEditingController();
  final password = TextEditingController();

  void register() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Parent Registered")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parent Registration"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: birthCert, decoration: const InputDecoration(labelText: "Birth Certificate No")),
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
