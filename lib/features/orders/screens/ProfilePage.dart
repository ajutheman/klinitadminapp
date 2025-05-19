// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../base/widget_utils.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   String name = '';
//   String email = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAdminInfo();
//   }
//
//   Future<void> _loadAdminInfo() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       name = prefs.getString('admin_name') ?? '';
//       email = prefs.getString('admin_email') ?? '';
//     });
//   }
//
//   Future<void> _logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     if (mounted) {
//       Navigator.pushReplacementNamed(context, '/login'); // Adjust your route
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: getCustomFont(" Profile ", 22, Colors.black, 2,
//             fontWeight: FontWeight.bold),
//         // const Text("📅 Daily Subscription Schedules"),
//         backgroundColor: Colors.white70,
//         // title: const Text("Profile"),
//         // backgroundColor: Colors.indigo,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Admin Info",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             Row(children: [
//               const Icon(Icons.person),
//               const SizedBox(width: 8),
//               Text(name)
//             ]),
//             const SizedBox(height: 8),
//             Row(children: [
//               const Icon(Icons.email),
//               const SizedBox(width: 8),
//               Text(email)
//             ]),
//             const Spacer(),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: _logout,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 icon: const Icon(Icons.logout),
//                 label: const Text("Logout"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/app_theme.dart';
import '../../../base/widget_utils.dart';

class ProfilePage extends StatefulWidget {
  /// Called to flip between light & dark mode
  // final VoidCallback onToggleTheme;

  const ProfilePage({
    Key? key,
    // required this.onToggleTheme,
  }) : super(key: key);

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
    if (mounted) Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text('Profile', style: theme.textTheme.headlineSmall),
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
              color: theme.colorScheme.onPrimary,
            ),
            // onPressed: widget.onToggleTheme,
            onPressed: () {

            },
            tooltip: 'Toggle Light/Dark',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: theme.cardColor,
          elevation: 4,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Admin Info',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colorScheme.secondary)),
                const SizedBox(height: 16),

                _infoRow(theme, Icons.person, 'Name', name),
                const SizedBox(height: 8),
                _infoRow(theme, Icons.email, 'Email', email),

                const Spacer(),

                Center(
                  child: ElevatedButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.softRed,
                      foregroundColor: AppTheme.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      textStyle: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
      ThemeData theme, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.secondary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value.isNotEmpty ? value : '—'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
