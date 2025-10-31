import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Name: Meghana'),
            subtitle: Text('Role: Parent'),
          ),
          const ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone: +91 9876543210'),
          ),
          const ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Anganwadi Center: ANG001'),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
