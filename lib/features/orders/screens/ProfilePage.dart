import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/widget_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadAdminInfo();
  }

  Future<void> _loadAdminInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('admin_name') ?? '';
      email = prefs.getString('admin_email') ?? '';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login'); // Adjust your route
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getCustomFont(" Profile ", 22, Colors.black, 2,
            fontWeight: FontWeight.bold),
        // const Text("📅 Daily Subscription Schedules"),
        backgroundColor: Colors.white70,
        // title: const Text("Profile"),
        // backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Admin Info",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.person),
              const SizedBox(width: 8),
              Text(name)
            ]),
            const SizedBox(height: 8),
            Row(children: [
              const Icon(Icons.email),
              const SizedBox(width: 8),
              Text(email)
            ]),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
