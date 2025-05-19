// import 'package:flutter/material.dart';
//
// import '../../../base/widget_utils.dart';
// import '../models/employee_model.dart';
//
// class EmployeeDetailPage extends StatelessWidget {
//   final Employee employee;
//
//   const EmployeeDetailPage({super.key, required this.employee});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: getCustomFont(employee.name, 22, Colors.black, 2,
//             fontWeight: FontWeight.bold),
//         // const Text("📅 Daily Subscription Schedules"),
//         backgroundColor: Colors.white70,
//         // title: Text(employee.name),
//         // backgroundColor: Colors.indigo,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Card(
//           elevation: 6,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(employee.image),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(employee.name,
//                     style: const TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Chip(
//                   label: Text(employee.status.toUpperCase()),
//                   backgroundColor: employee.status == 'active'
//                       ? Colors.green.shade100
//                       : Colors.red.shade100,
//                 ),
//                 const SizedBox(height: 16),
//                 _infoRow(Icons.phone, "Phone", employee.phone1),
//                 _infoRow(Icons.email, "Email", employee.email),
//                 _infoRow(Icons.house, "Street", employee.city ?? "-"),
//                 _infoRow(Icons.location_city, "City", employee.city ?? "-"),
//                 _infoRow(Icons.flag, "State", employee.state ?? "-"),
//                 _infoRow(Icons.map, "Country", employee.country ?? "-"),
//                 _infoRow(Icons.mail, "Postal Code", employee.postalCode ?? "-"),
//                 _infoRow(
//                     Icons.business, "Building", employee.buildingName ?? "-"),
//                 _infoRow(
//                     Icons.home, "Apartment", employee.apartmentNumber ?? "-"),
//                 _infoRow(
//                     Icons.lock, "Passport", employee.passportNumber ?? "-"),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: Colors.blueGrey),
//           const SizedBox(width: 10),
//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 style: const TextStyle(color: Colors.black87),
//                 children: [
//                   TextSpan(
//                     text: "$label: ",
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   TextSpan(text: value),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../base/app_theme.dart';
import '../models/employee_model.dart';

class EmployeeDetailPage extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String fmtDate(DateTime? dt) =>
        dt == null ? '-' : DateFormat.yMMMd().add_jm().format(dt);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(employee.name, style: theme.textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: theme.cardColor,
          elevation: 6,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar + Name + Status
                CircleAvatar(
                  radius: 140,
                  backgroundColor:
                  theme.colorScheme.secondary.withOpacity(0.2),
                  backgroundImage: NetworkImage(employee.image),
                ),
                const SizedBox(height: 16),
                Text(employee.name, style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Chip(
                  label: Text(
                    employee.status.toUpperCase(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: employee.status == 'active'
                          ? AppTheme.mintGreen
                          : AppTheme.softRed,
                    ),
                  ),
                  backgroundColor: employee.status == 'active'
                      ? AppTheme.mintGreen.withOpacity(0.2)
                      : AppTheme.softRed.withOpacity(0.2),
                ),
                const SizedBox(height: 24),

                // ── Contact ──────────────────────────────
                Text('Contact', style: theme.textTheme.titleMedium),
                const Divider(),
                _infoRow(theme, Icons.phone, 'Phone 1', employee.phone1),
                _infoRow(theme, Icons.phone_android, 'Phone 2',
                    employee.phone2 ?? '-'),
                _infoRow(theme, Icons.email, 'Email', employee.email),
                _infoRow(theme, Icons.notifications, 'FCM Token',
                    employee.fcmToken ?? '-'),
                const SizedBox(height: 24),

                // ── Address ──────────────────────────────
                Text('Address', style: theme.textTheme.titleMedium),
                const Divider(),
                _infoRow(theme, Icons.home, 'Street', employee.street ?? '-'),
                _infoRow(theme, Icons.location_city, 'City', employee.city ?? '-'),
                _infoRow(theme, Icons.flag, 'State', employee.state ?? '-'),
                _infoRow(theme, Icons.public, 'Country', employee.country ?? '-'),
                _infoRow(theme, Icons.mail_outline, 'Postal Code',
                    employee.postalCode ?? '-'),
                _infoRow(theme, Icons.apartment, 'Building',
                    employee.buildingName ?? '-'),
                _infoRow(theme, Icons.house, 'House Number',
                    employee.houseNumber ?? '-'),
                _infoRow(theme, Icons.account_balance, 'Apartment No.',
                    employee.apartmentNumber ?? '-'),
                const SizedBox(height: 24),

                // ── Documents ────────────────────────────
                Text('Documents', style: theme.textTheme.titleMedium),
                const Divider(),
                _infoRow(theme, Icons.vpn_key, 'Passport No.',
                    employee.passportNumber ?? '-'),
                _infoRow(theme, Icons.calendar_today, 'Passport Expires',
                    fmtDate(employee.passportExpiryDate)),
                _infoRow(theme, Icons.calendar_today, 'Visa Expires',
                    fmtDate(employee.visaExpiryDate)),
                _infoRow(theme, Icons.credit_card, 'Visa No.',
                    employee.visaNumber ?? '-'),
                _infoRow(theme, Icons.account_box, 'Emirates ID',
                    employee.emiratesId ?? '-'),
                _infoRow(theme, Icons.calendar_today, 'Emirates ID Expires',
                    fmtDate(employee.emiratesIdExpiryDate)),
                const SizedBox(height: 24),

                // ── Contract ─────────────────────────────
                Text('Contract', style: theme.textTheme.titleMedium),
                const Divider(),
                _infoRow(theme, Icons.work, 'Type', employee.contractType),
                _infoRow(theme, Icons.calendar_today, 'Valid Until',
                    fmtDate(employee.contractValidity)),
                const SizedBox(height: 24),

                // ── Timestamps & Meta ────────────────────
                Text('Meta & Audit', style: theme.textTheme.titleMedium),
                const Divider(),
                _infoRow(theme, Icons.lock, 'Encrypted ID',
                    employee.encryptedId),
                _infoRow(theme, Icons.delete, 'Deleted At',
                    fmtDate(employee.deletedAt)),
                _infoRow(theme, Icons.date_range, 'Created At',
                    fmtDate(employee.createdAt)),
                _infoRow(theme, Icons.update, 'Updated At',
                    fmtDate(employee.updatedAt)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(ThemeData theme, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
