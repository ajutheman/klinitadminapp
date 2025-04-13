import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_model.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.orderNumber}'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionCard(
            title: 'Customer Details',
            children: [
              _infoRow(Icons.person, order.customer?.name ?? '-'),
              _infoRow(Icons.phone, order.customer?.mobile ?? '-'),
              _infoRow(Icons.email, order.customer?.email ?? '-'),
            ],
          ),
          _sectionCard(
            title: 'Address',
            children: [
              _infoRow(Icons.location_on,
                  '${order.address?.buildingName}, ${order.address?.area}'),
            ],
          ),
          _sectionCard(
            title: 'Payment',
            children: [
              _infoRow(Icons.payment,
                  '${order.paymentMethod} - ${order.paymentStatus}'),
              _infoRow(Icons.attach_money,
                  'Total: AED ${order.total.toStringAsFixed(2)}'),
              if (order.createdAt != null)
                _infoRow(Icons.access_time,
                    'Ordered on: ${DateFormat.yMMMd().add_jm().format(order.createdAt!)}'),
            ],
          ),
          if (order.orderItems.isNotEmpty)
            _sectionCard(
              title: 'Items',
              children: order.orderItems
                  .map((item) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(item.thirdCategory?.image ?? ''),
                          backgroundColor: Colors.grey[200],
                        ),
                        title: Text(
                          item.thirdCategory?.name ?? 'Cleaning Service',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("× ${item.employeeCount} Employee(s)"),
                            if (item.subscriptionFrequency != null)
                              Text(
                                  "Frequency: ${item.subscriptionFrequency} times/week"),
                            Text(
                                "Item Total: AED ${item.itemTotal.toStringAsFixed(2)}"),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          _sectionCard(
            title: 'Assigned Employees',
            children: order.workAssignments.isEmpty
                ? [
                    const Text(
                      "No employees assigned.",
                      style: TextStyle(color: Colors.grey),
                    )
                  ]
                : order.workAssignments
                    .map((assign) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(assign.employee.image),
                          ),
                          title: Text(assign.employee.name),
                          subtitle: Text("Status: ${assign.workStatus}"),
                        ))
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.indigo.shade400),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              )),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}
