import 'package:flutter/material.dart';

import '../../../base/widget_utils.dart';
import '../models/employee_model.dart';

class EmployeeDetailPage extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getCustomFont(employee.name, 22, Colors.black, 2,
            fontWeight: FontWeight.bold),
        // const Text("📅 Daily Subscription Schedules"),
        backgroundColor: Colors.white70,
        // title: Text(employee.name),
        // backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(employee.image),
                ),
                const SizedBox(height: 16),
                Text(employee.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Chip(
                  label: Text(employee.status.toUpperCase()),
                  backgroundColor: employee.status == 'active'
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                ),
                const SizedBox(height: 16),
                _infoRow(Icons.phone, "Phone", employee.phone1),
                _infoRow(Icons.email, "Email", employee.email),
                _infoRow(Icons.house, "Street", employee.city ?? "-"),
                _infoRow(Icons.location_city, "City", employee.city ?? "-"),
                _infoRow(Icons.flag, "State", employee.state ?? "-"),
                _infoRow(Icons.map, "Country", employee.country ?? "-"),
                _infoRow(Icons.mail, "Postal Code", employee.postalCode ?? "-"),
                _infoRow(
                    Icons.business, "Building", employee.buildingName ?? "-"),
                _infoRow(
                    Icons.home, "Apartment", employee.apartmentNumber ?? "-"),
                _infoRow(
                    Icons.lock, "Passport", employee.passportNumber ?? "-"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
