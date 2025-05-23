// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../models/order_model.dart';
//
// class OrderDetailPage extends StatelessWidget {
//   final Order order;
//
//   const OrderDetailPage({super.key, required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order #${order.orderNumber}'),
//         backgroundColor: Colors.indigo,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _sectionCard(
//             title: 'Customer Details',
//             children: [
//               _infoRow(Icons.person, order.customer?.name ?? '-'),
//               _infoRow(Icons.phone, order.customer?.mobile ?? '-'),
//               _infoRow(Icons.email, order.customer?.email ?? '-'),
//             ],
//           ),
//           _sectionCard(
//             title: 'Address',
//             children: [
//               _infoRow(Icons.location_on,
//                   '${order.address?.buildingName}, ${order.address?.area}'),
//             ],
//           ),
//           _sectionCard(
//             title: 'Payment',
//             children: [
//               _infoRow(Icons.payment,
//                   '${order.paymentMethod} - ${order.paymentStatus}'),
//               _infoRow(Icons.attach_money,
//                   'Total: AED ${order.total.toStringAsFixed(2)}'),
//               if (order.createdAt != null)
//                 _infoRow(Icons.access_time,
//                     'Ordered on: ${DateFormat.yMMMd().add_jm().format(order.createdAt!)}'),
//             ],
//           ),
//           if (order.orderItems.isNotEmpty)
//             _sectionCard(
//               title: 'Items',
//               children: order.orderItems
//                   .map((item) => ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         leading: CircleAvatar(
//                           backgroundImage:
//                               NetworkImage(item.thirdCategory?.image ?? ''),
//                           backgroundColor: Colors.grey[200],
//                         ),
//                         title: Text(
//                           item.thirdCategory?.name ?? 'Cleaning Service',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("× ${item.employeeCount} Employee(s)"),
//                             if (item.subscriptionFrequency != null)
//                               Text(
//                                   "Frequency: ${item.subscriptionFrequency} times/week"),
//                             Text(
//                                 "Item Total: AED ${item.itemTotal.toStringAsFixed(2)}"),
//                           ],
//                         ),
//                       ))
//                   .toList(),
//             ),
//           _sectionCard(
//             title: 'Assigned Employees',
//             children: order.workAssignments.isEmpty
//                 ? [
//                     const Text(
//                       "No employees assigned.",
//                       style: TextStyle(color: Colors.grey),
//                     )
//                   ]
//                 : order.workAssignments
//                     .map((assign) => ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           leading: CircleAvatar(
//                             backgroundImage:
//                                 NetworkImage(assign.employee.image),
//                           ),
//                           title: Text(assign.employee.name),
//                           subtitle: Text("Status: ${assign.workStatus}"),
//                         ))
//                     .toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: Colors.indigo.shade400),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(text,
//                 style: const TextStyle(fontSize: 14, color: Colors.black87)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionCard({required String title, required List<Widget> children}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.indigo.shade50, Colors.white],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.indigo.withOpacity(0.1),
//             blurRadius: 6,
//             offset: const Offset(0, 4),
//           )
//         ],
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.indigo.shade100),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.indigo.shade700,
//               )),
//           const SizedBox(height: 10),
//           ...children,
//         ],
//       ),
//     );
//   }
// }
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../models/order_model.dart';
//
// class OrderDetailPage extends StatelessWidget {
//   final Order order;
//
//   const OrderDetailPage({super.key, required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order #${order.orderNumber}'),
//         backgroundColor: Colors.indigo,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _sectionCard(
//             title: 'Basic Info',
//             children: [
//               _infoRow(Icons.confirmation_num, 'ID: ${order.id}'),
//               _infoRow(Icons.event, 'Scheduled ID: ${order.scheduledTimeId}'),
//               if (order.bookingDate != null)
//                 _infoRow(Icons.book_online,
//                     'Booking Date: ${DateFormat.yMMMd().format(order.bookingDate!)}'),
//               _infoRow(Icons.info, 'Status: ${order.orderStatus}'),
//               if (order.assignStatus.isNotEmpty)
//                 _infoRow(Icons.group, 'Assign Status: ${order.assignStatus}'),
//             ],
//           ),
//
//           _sectionCard(
//             title: 'Customer Details',
//             children: [
//               _infoRow(Icons.person, order.customer?.name ?? '-'),
//               _infoRow(Icons.phone, order.customer?.mobile ?? '-'),
//               _infoRow(Icons.email, order.customer?.email ?? '-'),
//               if (order.referralCode != null && order.referralCode!.isNotEmpty)
//                 _infoRow(Icons.redeem,
//                     'Referral: ${order.referralCode} (+${order.referralBonusCoins} coins)'),
//             ],
//           ),
//
//           _sectionCard(
//             title: 'Address',
//             children: [
//               _infoRow(Icons.location_on,
//                   '${order.address?.buildingName}, ${order.address?.area}'),
//             ],
//           ),
//
//           _sectionCard(
//             title: 'Payment & Pricing',
//             children: [
//               _infoRow(Icons.payment,
//                   '${order.paymentMethod.toUpperCase()} - ${order.paymentStatus.toUpperCase()}'),
//               _infoRow(Icons.attach_money,
//                   'Subtotal: AED ${order.subtotal.toStringAsFixed(2)}'),
//               _infoRow(Icons.percent,
//                   'Tax (${order.taxRate.toStringAsFixed(1)}%): AED ${order.taxAmount.toStringAsFixed(2)}'),
//               if (order.couponCode != null && order.couponCode!.isNotEmpty)
//                 _infoRow(Icons.card_giftcard,
//                     'Coupon ${order.couponCode}: -AED ${order.couponDiscount.toStringAsFixed(2)}'),
//               _infoRow(Icons.money, 'Total: AED ${order.total.toStringAsFixed(2)}'),
//               if (order.refundStatus != null)
//                 _infoRow(Icons.refresh,
//                     'Refund: ${order.refundStatus} — AED ${order.refundAmount?.toStringAsFixed(2) ?? "0.00"}'),
//               if (order.cancellationReason != null)
//                 _infoRow(Icons.cancel,
//                     'Cancelled because: ${order.cancellationReason}'),
//               if (order.paymentDetails != null) ...[
//                 const SizedBox(height: 8),
//                 Text('▶︎ Raw Payment JSON:',
//                     style:
//                     TextStyle(fontSize: 12, color: Colors.grey.shade600)),
//                 Text(
//                   const JsonEncoder.withIndent('  ')
//                       .convert(order.paymentDetails),
//                   style: const TextStyle(
//                       fontSize: 11, fontFamily: 'Courier'),
//                 ),
//               ],
//             ],
//           ),
// // inside your OrderDetailPage.build → ListView.children:
//
//           _sectionCard(
//             title: 'Payment & Pricing',
//             children: [
//               _infoRow(Icons.payment,
//                   '${order.paymentMethod.toUpperCase()} — ${order.paymentStatus.toUpperCase()}'),
//               _infoRow(Icons.attach_money,
//                   'Subtotal: AED ${order.subtotal.toStringAsFixed(2)}'),
//               _infoRow(Icons.percent,
//                   'Tax (${order.taxRate.toStringAsFixed(1)}%): AED ${order.taxAmount.toStringAsFixed(2)}'),
//               if (order.couponCode != null && order.couponCode!.isNotEmpty)
//                 _infoRow(Icons.card_giftcard,
//                     'Coupon ${order.couponCode}: –AED ${order.couponDiscount.toStringAsFixed(2)}'),
//               _infoRow(Icons.money,
//                   'Total: AED ${order.total.toStringAsFixed(2)}'),
//               if (order.refundStatus != null)
//                 _infoRow(Icons.refresh,
//                     'Refund: ${order.refundStatus} — AED ${order.refundAmount?.toStringAsFixed(2) ?? "0.00"}'),
//               if (order.cancellationReason != null)
//                 _infoRow(Icons.cancel,
//                     'Cancelled because: ${order.cancellationReason}'),
//
//               // replace raw JSON with a button that shows the parsed fields
//               if (order.paymentDetails != null) ...[
//                 const SizedBox(height: 12),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.receipt_long, size: 18),
//                   label: const Text('View Payment Details'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.indigo,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () => _showPaymentDetailsBottomSheet(context, order.paymentDetails!),
//                 ),
//               ],
//             ],
//           ),
//
//           _sectionCard(
//             title: 'Subscription',
//             children: [
//               _infoRow(Icons.repeat, order.hasSubscription
//                   ? 'Every ${order.subscriptionDuration} month(s)'
//                   : 'None'),
//             ],
//           ),
//
//           if (order.notes != null && order.notes!.isNotEmpty)
//             _sectionCard(
//               title: 'Notes',
//               children: [
//                 Text(order.notes!,
//                     style: const TextStyle(
//                         fontSize: 14, fontStyle: FontStyle.italic)),
//               ],
//             ),
//
//           if (order.orderItems.isNotEmpty)
//             _sectionCard(
//               title: 'Items',
//               children: order.orderItems.map((item) {
//                 return ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   leading: CircleAvatar(
//                     backgroundImage:
//                     NetworkImage(item.thirdCategory?.image ?? ''),
//                     backgroundColor: Colors.grey[200],
//                   ),
//                   title: Text(item.thirdCategory?.name ?? 'Service',
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("× ${item.employeeCount}"),
//                       if (item.subscriptionFrequency != null)
//                         Text(
//                             "Frequency: ${item.subscriptionFrequency} per week"),
//                       Text(
//                           "Item Total: AED ${item.itemTotal.toStringAsFixed(2)}"),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//
//           _sectionCard(
//             title: 'Assigned Employees',
//             children: order.workAssignments.isEmpty
//                 ? [
//               const Text("No employees assigned.",
//                   style: TextStyle(color: Colors.grey)),
//             ]
//                 : order.workAssignments.map((assign) {
//               return ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: CircleAvatar(
//                   backgroundImage:
//                   NetworkImage(assign.employee.image),
//                 ),
//                 title: Text(assign.employee.name),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Status: ${assign.workStatus}"),
//                     if (assign.startTime != null)
//                       Text(
//                           "Start: ${DateFormat.jm().format(assign.startTime!)}"),
//                     if (assign.endTime != null)
//                       Text(
//                           "End:   ${DateFormat.jm().format(assign.endTime!)}"),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: Colors.indigo.shade400),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(text,
//                 style: const TextStyle(fontSize: 14, color: Colors.black87)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionCard(
//       {required String title, required List<Widget> children}) =>
//       Container(
//         margin: const EdgeInsets.only(bottom: 20),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.indigo.shade50, Colors.white],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.indigo.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, 4),
//             )
//           ],
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.indigo.shade100),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.indigo.shade700,
//                 )),
//             const SizedBox(height: 10),
//             ...children,
//           ],
//         ),
//       );
// }
// void _showPaymentDetailsBottomSheet(
//     BuildContext context, Map<String, dynamic> details) {
//   // Pick only the most useful fields
//   final simpleFields = <String, String>{
//     'Payment ID': details['id']?.toString() ?? '-',
//     'Status': details['status']?.toString() ?? '-',
//     'Amount': details['amount_received'] != null
//         ? 'AED ${(details['amount_received'] as num  ).toStringAsFixed(2)}'
//         : '-',
//     'Currency': details['currency']?.toString().toUpperCase() ?? '-',
//     'Method': (details['payment_method_types'] as List<dynamic>?)
//         ?.join(', ')
//         .toUpperCase() ??
//         '-',
//     'Description': details['description']?.toString() ?? '-',
//     'Created': details['created'] != null
//         ? DateFormat.yMMMd().add_jm().format(
//         DateTime.fromMillisecondsSinceEpoch(
//             (details['created'] as int) * 1000))
//         : '-',
//   };
//
//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (ctx) => Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Payment Details',
//               style: Theme.of(context).textTheme.labelMedium ),
//           const SizedBox(height: 12),
//           // Render each simple field in a ListTile
//           ...simpleFields.entries.map((e) => ListTile(
//             dense: true,
//             contentPadding: EdgeInsets.zero,
//             title: Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold)),
//             subtitle: Text(e.value),
//           )),
//           const Divider(),
//           TextButton.icon(
//             onPressed: () {
//               // show full JSON in a dialog if absolutely needed
//               Navigator.pop(ctx);
//               _showRawJsonDialog(context, details);
//             },
//             icon: const Icon(Icons.code, size: 18),
//             label: const Text('View full JSON'),
//           ),
//           const SizedBox(height: 8),
//         ],
//       ),
//     ),
//   );
// }
//
// void _showRawJsonDialog(
//     BuildContext context, Map<String, dynamic> details) {
//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       title: const Text('Full Payment JSON'),
//       content: SingleChildScrollView(
//         child: Text(
//           const JsonEncoder.withIndent('  ').convert(details),
//           style: const TextStyle(fontFamily: 'Courier', fontSize: 12),
//         ),
//       ),
//       actions: [
//         TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'))
//       ],
//     ),
//   );
// }

// // lib/pages/order_detail_page.dart
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../models/order_model.dart';
//
// class OrderDetailPage extends StatelessWidget {
//   final Order order;
//
//   const OrderDetailPage({super.key, required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     // Gather each section into a list
//     final sections = <Widget>[
//       _animatedCard(
//         _section(
//           title: 'Basic Info',
//           children: [
//             _infoRow(Icons.confirmation_num, 'ID: ${order.id}'),
//             _infoRow(Icons.event, 'Scheduled ID: ${order.scheduledTimeId}'),
//             if (order.bookingDate != null)
//               _infoRow(
//                 Icons.book_online,
//                 'Booking Date: ${DateFormat.yMMMd().format(order.bookingDate!)}',
//               ),
//             _infoRow(Icons.info, 'Status: ${order.orderStatus}'),
//             if (order.assignStatus.isNotEmpty)
//               _infoRow(Icons.group, 'Assign Status: ${order.assignStatus}'),
//           ],
//         ),
//       ),
//
//       _animatedCard(
//         _section(
//           title: 'Customer Details',
//           children: [
//             _infoRow(Icons.person, order.customer?.name ?? '-'),
//             _infoRow(Icons.phone, order.customer?.mobile ?? '-'),
//             _infoRow(Icons.email, order.customer?.email ?? '-'),
//             if (order.referralCode?.isNotEmpty ?? false)
//               _infoRow(
//                   Icons.redeem,
//                   'Referral: ${order.referralCode} '
//                       '(+${order.referralBonusCoins} coins)'),
//           ],
//         ),
//       ),
//
//       _animatedCard(
//         _section(
//           title: 'Address',
//           children: [
//             _infoRow(Icons.location_on,
//                 '${order.address?.buildingName}, ${order.address?.area}'),
//           ],
//         ),
//       ),
//
//       _animatedCard(
//         _section(
//           title: 'Payment & Pricing',
//           children: [
//             _infoRow(Icons.payment,
//                 '${order.paymentMethod.toUpperCase()} — ${order.paymentStatus.toUpperCase()}'),
//             _infoRow(Icons.attach_money,
//                 'Subtotal: AED ${order.subtotal.toStringAsFixed(2)}'),
//             _infoRow(Icons.percent,
//                 'Tax (${order.taxRate.toStringAsFixed(1)}%): AED ${order.taxAmount.toStringAsFixed(2)}'),
//             if (order.couponCode?.isNotEmpty ?? false)
//               _infoRow(Icons.card_giftcard,
//                   'Coupon ${order.couponCode}: -AED ${order.couponDiscount.toStringAsFixed(2)}'),
//             _infoRow(Icons.money,
//                 'Total: AED ${order.total.toStringAsFixed(2)}'),
//             if (order.refundStatus != null)
//               _infoRow(Icons.refresh,
//                   'Refund: ${order.refundStatus} — AED ${order.refundAmount?.toStringAsFixed(2) ?? "0.00"}'),
//             if (order.cancellationReason != null)
//               _infoRow(Icons.cancel,
//                   'Cancelled because: ${order.cancellationReason}'),
//             const SizedBox(height: 8),
//             TextButton.icon(
//               onPressed: () => _showPaymentDetailsBottomSheet(
//                   context, order.paymentDetails!),
//               icon: const Icon(Icons.info_outline, size: 18),
//               label: const Text('View payment details'),
//             ),
//           ],
//         ),
//       ),
//
//       _animatedCard(
//         _section(
//           title: 'Subscription',
//           children: [
//             _infoRow(
//                 Icons.repeat,
//                 order.hasSubscription
//                     ? 'Every ${order.subscriptionDuration} month(s)'
//                     : 'None'),
//           ],
//         ),
//       ),
//
//       _animatedCard(
//         _section(
//           title: 'Preferences',
//           children: [
//             _infoRow(Icons.bedroom_parent_outlined,
//                 'Bedrooms: ${order.bedrooms ?? '-'}'),
//             _infoRow(Icons.pets,
//                 'Pets Present: ${order.petsPresent ? order.petsPresent : 'None'}'),
//             _infoRow(Icons.bed, 'Beds: ${order.beds ?? '-'}'),
//             _infoRow(Icons.weekend, 'Sofa Beds: ${order.sofaBeds ?? '-'}'),
//             _infoRow(Icons.label_outline_sharp,
//                 'With Linen: ${order.withLinen == 1 ? 'Yes' : 'No'}'),
//             _infoRow(Icons.shopping_bag,
//                 'With Supplies: ${order.withSupplies == 1 ? 'Yes' : 'No'}'),
//             _infoRow(Icons.door_front_door,
//                 'Door Access Code: ${order.doorAccessCode ?? '-'}'),
//             _infoRow(Icons.people, 'Occupancy: ${order.occupancy ?? '-'}'),
//           ],
//         ),
//       ),
//
//       _animatedCard(
//         _section(
//           title: 'Time & Date',
//           children: [
//             _infoRow(
//               Icons.access_time,
//               'Check-in: ${order.checkInTime != null ? DateFormat.jm().format(order.checkInTime! as DateTime) : '-'}',
//             ),
//             _infoRow(
//               Icons.access_time_outlined,
//               'Check-out: ${order.checkOutTime != null ? DateFormat.jm().format(order.checkOutTime! as DateTime) : '-'}',
//             ),
//             if (order.bookingDate != null)
//               _infoRow(Icons.book_online,
//                   'Booking Date: ${DateFormat.yMMMd().format(order.bookingDate!)}'),
//           ],
//         ),
//       ),
//
//       _animatedCard(
//         _section(
//           title: 'Coupon & Referral',
//           children: [
//             _infoRow(Icons.local_offer,
//                 'Coupon Code: ${order.couponCode ?? '-'}'),
//             _infoRow(Icons.money_off,
//                 'Coupon Discount: AED ${order.couponDiscount.toStringAsFixed(2)}'),
//             _infoRow(Icons.redeem,
//                 'Referral Code: ${order.referralCode ?? '-'}'),
//             _infoRow(Icons.stars,
//                 'Referral Bonus: ${order.referralBonusCoins} coins'),
//           ],
//         ),
//       ),
//
//       _animatedCard(
//         _section(
//           title: 'Order Meta',
//           children: [
//             _infoRow(Icons.home_work,
//                 'Customer Address ID: ${order.customerAddressId}'),
//             _infoRow(Icons.schedule,
//                 'Scheduled Time ID: ${order.scheduledTimeId}'),
//           ],
//         ),
//       ),
//
//       if (order.notes?.isNotEmpty ?? false)
//         _animatedCard(
//           _section(
//             title: 'Notes',
//             children: [
//               Text(order.notes!,
//                   style: const TextStyle(
//                       fontSize: 14, fontStyle: FontStyle.italic)),
//             ],
//           ),
//         ),
//
//       if (order.orderItems.isNotEmpty)
//         _animatedCard(
//           _section(
//             title: 'Items',
//             children: order.orderItems.map((item) {
//               return ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: CircleAvatar(
//                   backgroundImage:
//                   NetworkImage(item.thirdCategory?.image ?? ''),
//                   backgroundColor: Colors.grey[200],
//                 ),
//                 title: Text(item.thirdCategory?.name ?? 'Service',
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("× ${item.employeeCount}"),
//                     if (item.subscriptionFrequency != null)
//                       Text("Frequency: ${item.subscriptionFrequency} per week"),
//                     Text(
//                         "Item Total: AED ${item.itemTotal.toStringAsFixed(2)}"),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//
//       _animatedCard(
//         _section(
//           title: 'Assigned Employees',
//           children: order.workAssignments.isEmpty
//               ? [
//             const Text("No employees assigned.",
//                 style: TextStyle(color: Colors.grey)),
//           ]
//               : order.workAssignments.map((assign) {
//             return ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: CircleAvatar(
//                 backgroundImage: NetworkImage(assign.employee.image),
//               ),
//               title: Text(assign.employee.name),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Status: ${assign.workStatus}"),
//                   if (assign.startTime != null)
//                     Text(
//                         "Start: ${DateFormat.jm().format(assign.startTime!)}"),
//                   if (assign.endTime != null)
//                     Text(
//                         "End:   ${DateFormat.jm().format(assign.endTime!)}"),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order #${order.orderNumber}'),
//         backgroundColor: Colors.indigo,
//       ),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: sections.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 12),
//         itemBuilder: (_, idx) => sections[idx],
//       ),
//     );
//   }
//
//   /// Wraps each section card in a subtle scale animation
//   Widget _animatedCard(Widget child) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.95, end: 1.0),
//       duration: const Duration(milliseconds: 300),
//       builder: (_, value, widget) => Transform.scale(scale: value, child: widget),
//       child: child,
//     );
//   }
//
//   /// Creates a rounded card with a colored side border and an accent header
//   Widget _section({required String title, required List<Widget> children}) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: Colors.indigo.shade300, width: 3),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       elevation: 4,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // accent header
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.indigo.shade50,
//               borderRadius:
//               const BorderRadius.vertical(top: Radius.circular(9)),
//             ),
//             child: Text(title,
//                 style: TextStyle(
//                     color: Colors.indigo.shade800,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(children: children),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// A row with a circular icon background
//   Widget _infoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.indigo.shade100,
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, size: 20, color: Colors.indigo),
//         ),
//         const SizedBox(width: 12),
//         Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
//       ]),
//     );
//   }
//
//   /// Bottom sheet summarizing key payment fields, with option to view raw JSON
//   void _showPaymentDetailsBottomSheet(
//       BuildContext context, Map<String, dynamic> d) {
//     final simple = <String, String>{
//       'Payment ID': d['id']?.toString() ?? '-',
//       'Status': d['status']?.toString() ?? '-',
//       'Amount': d['amount_received'] != null
//           ? 'AED ${(d['amount_received'] as num).toStringAsFixed(2)}'
//           : '-',
//       'Currency': d['currency']?.toString().toUpperCase() ?? '-',
//       'Method': (d['payment_method_types'] as List<dynamic>?)
//           ?.join(', ')
//           .toUpperCase() ??
//           '-',
//       'Description': d['description']?.toString() ?? '-',
//       'Created': d['created'] != null
//           ? DateFormat.yMMMd().add_jm().format(
//           DateTime.fromMillisecondsSinceEpoch((d['created'] as int) * 1000))
//           : '-',
//     };
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white.withOpacity(0.95),
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
//       builder: (_) => Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           Text('Payment Details',
//               style: Theme.of(context).textTheme.titleLarge),
//           const SizedBox(height: 12),
//           ...simple.entries.map((e) => ListTile(
//             dense: true,
//             contentPadding: EdgeInsets.zero,
//             title:
//             Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold)),
//             subtitle: Text(e.value),
//           )),
//           const Divider(),
//           TextButton.icon(
//             onPressed: () {
//               Navigator.pop(context);
//               _showRawJsonDialog(context, d);
//             },
//             icon: const Icon(Icons.code, size: 18),
//             label: const Text('View full JSON'),
//           ),
//           const SizedBox(height: 8),
//         ]),
//       ),
//     );
//   }
//
//   /// Plain dialog showing the full JSON payload
//   void _showRawJsonDialog(
//       BuildContext context, Map<String, dynamic> details) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Full Payment JSON'),
//         content: SingleChildScrollView(
//           child: Text(
//             const JsonEncoder.withIndent('  ').convert(details),
//             style: const TextStyle(fontFamily: 'Courier', fontSize: 12),
//           ),
//         ),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context), child: const Text('Close'))
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_model.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = <Widget>[
      _animatedCard(
        _section(
          context,
          title: 'Basic Info',
          children: [
            _infoRow(theme, Icons.confirmation_num, 'ID: ${order.id}'),
            _infoRow(theme, Icons.event, 'Scheduled ID: ${order.scheduledTimeId}'),
            if (order.bookingDate != null)
              _infoRow(
                theme,
                Icons.book_online,
                'Booking Date: ${DateFormat.yMMMd().format(order.bookingDate!)}',
              ),
            _infoRow(theme, Icons.info, 'Status: ${order.orderStatus}'),
            if (order.assignStatus.isNotEmpty)
              _infoRow(theme, Icons.group, 'Assign Status: ${order.assignStatus}'),
          ],
        ),
      ),

      _animatedCard(
        _section(
          context,
          title: 'Customer Details',
          children: [
            _infoRow(theme, Icons.person, order.customer?.name ?? '-'),
            _infoRow(theme, Icons.phone, order.customer?.mobile ?? '-'),
            _infoRow(theme, Icons.email, order.customer?.email ?? '-'),
            if ((order.referralCode ?? '').isNotEmpty)
              _infoRow(
                theme,
                Icons.redeem,
                'Referral: ${order.referralCode} (+${order.referralBonusCoins} coins)',
              ),
          ],
        ),
      ),

      _animatedCard(
        _section(
          context,
          title: 'Address',
          children: [
            _infoRow(
              theme,
              Icons.location_on,
              '${order.address?.buildingName}, ${order.address?.area}',
            ),
          ],
        ),
      ),
      if ((order.notes ?? '').isNotEmpty)
        _animatedCard(
          _section(
            context,
            title: 'Notes',
            children: [
              Text(order.notes!,
                  style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      _animatedCard(
        _section(
          context,
          title: 'Time & Date',
          children: [
            _infoRow(
              theme,
              Icons.access_time,
              'Check‑in: ${order.checkInTime != null ? DateFormat.jm().format(order.checkInTime! as DateTime) : '-'}',
            ),
            _infoRow(
              theme,
              Icons.access_time_outlined,
              'Check‑out: ${order.checkOutTime != null ? DateFormat.jm().format(order.checkOutTime! as DateTime) : '-'}',
            ),
            _infoRow(
              theme, Icons.access_time,
              'Check-in: ${order.checkInTime != null
                  ? DateFormat.jm().format(order.checkInTime!)
                  : '-'}',
            ),

            if (order.bookingDate != null)
              _infoRow(
                theme,
                Icons.book_online,
                'Booking Date: ${DateFormat.yMMMd().format(order.bookingDate!)}',
              ),
          ],
        ),
      ),
      _animatedCard(
        _section(
          context,
          title: 'Payment & Pricing',
          children: [
            _infoRow(
              theme,
              Icons.payment,
              '${order.paymentMethod.toUpperCase()} — ${order.paymentStatus.toUpperCase()}',
            ),
            _infoRow(
              theme,
              Icons.attach_money,
              'Subtotal: AED ${order.subtotal.toStringAsFixed(2)}',
            ),
            _infoRow(
              theme,
              Icons.percent,
              'Tax (${order.taxRate.toStringAsFixed(1)}%): AED ${order.taxAmount.toStringAsFixed(2)}',
            ),
            if ((order.couponCode ?? '').isNotEmpty)
              _infoRow(
                theme,
                Icons.card_giftcard,
                'Coupon ${order.couponCode}: -AED ${order.couponDiscount.toStringAsFixed(2)}',
              ),
            _infoRow(
              theme,
              Icons.money,
              'Total: AED ${order.total.toStringAsFixed(2)}',
            ),
            if (order.refundStatus != null)
              _infoRow(
                theme,
                Icons.refresh,
                'Refund: ${order.refundStatus} — AED ${order.refundAmount?.toStringAsFixed(2) ?? "0.00"}',
              ),
            if (order.cancellationReason != null)
              _infoRow(
                theme,
                Icons.cancel,
                'Cancelled: ${order.cancellationReason}',
              ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _showPaymentDetailsBottomSheet(
                  context, order.paymentDetails!),
              icon: Icon(Icons.info_outline, size: 18, color: theme.colorScheme.secondary),
              label: Text('View payment details', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.secondary)),
            ),
          ],
        ),
      ),

      _animatedCard(
        _section(
          context,
          title: 'Subscription',
          children: [
            _infoRow(
              theme,
              Icons.repeat,
              order.hasSubscription
                  ? 'Every ${order.subscriptionDuration} month(s)'
                  : 'None',
            ),
          ],
        ),
      ),
      if (order.orderItems.isNotEmpty)
        _animatedCard(
          _section(
            context,
            title: 'Items',
            children: order.orderItems.map((item) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.thirdCategory?.image ?? ''),
                  backgroundColor: theme.cardColor,
                ),
                title: Text(item.thirdCategory?.name ?? 'Service',
                    style: theme.textTheme.titleMedium),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("× ${item.employeeCount}", style: theme.textTheme.bodyMedium),
                    if (item.subscriptionFrequency != null)
                      Text("Freq: ${item.subscriptionFrequency}/wk", style: theme.textTheme.bodyMedium),
                    Text("Total: AED ${item.itemTotal.toStringAsFixed(2)}",
                        style: theme.textTheme.bodyMedium),
                  ],
                ),
              );
            }).toList(),
          ),
        ), _animatedCard(
        _section(
          context,
          title: 'Assigned Employees',
          children: order.workAssignments.isEmpty
              ? [ Text("No employees assigned.", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)) ]
              : order.workAssignments.map((assign) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(backgroundImage: NetworkImage(assign.employee.image)),
              title: Text(assign.employee.name, style: theme.textTheme.bodyMedium),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Status: ${assign.workStatus}", style: theme.textTheme.bodyMedium),
                  if (assign.startTime != null)
                    Text("Start: ${DateFormat.jm().format(assign.startTime!)}",
                        style: theme.textTheme.bodyMedium),
                  if (assign.endTime != null)
                    Text("End:   ${DateFormat.jm().format(assign.endTime!)}",
                        style: theme.textTheme.bodyMedium),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      _animatedCard(
        _section(
          context,
          title: 'Preferences',
          children: [
            _infoRow(theme, Icons.bedroom_parent_outlined, 'Bedrooms: ${order.bedrooms ?? '-'}'),
            _infoRow(theme, Icons.pets, 'Pets Present: ${order.petsPresent ? 'Yes' : 'No'}'),
            _infoRow(theme, Icons.bed, 'Beds: ${order.beds ?? '-'}'),
            _infoRow(theme, Icons.weekend, 'Sofa Beds: ${order.sofaBeds ?? '-'}'),
            _infoRow(theme, Icons.label_outline_sharp,
                'With Linen: ${order.withLinen == 1 ? 'Yes' : 'No'}'),
            _infoRow(theme, Icons.shopping_bag,
                'With Supplies: ${order.withSupplies == 1 ? 'Yes' : 'No'}'),
            _infoRow(theme, Icons.door_front_door,
                'Door Access: ${order.doorAccessCode ?? '-'}'),
            _infoRow(theme, Icons.people, 'Occupancy: ${order.occupancy ?? '-'}'),   _infoRow(theme, Icons.cleaning_services, 'Type: ${order.typeOfCleaning}'),
            _infoRow(theme, Icons.timer_outlined, 'Next Guest Check-In: ${order.nextGuestCheckInTime}'),
            _infoRow(theme, Icons.wifi, 'WiFi Code: ${order.wifiAccessCode}'),

          ],
        ),
      ),



      _animatedCard(
        _section(
          context,
          title: 'Coupon & Referral',
          children: [
            _infoRow(theme, Icons.local_offer, 'Coupon Code: ${order.couponCode ?? '-'}'),
            _infoRow(theme, Icons.money_off,
                'Coupon Discount: AED ${order.couponDiscount.toStringAsFixed(2)}'),
            _infoRow(theme, Icons.redeem, 'Referral Code: ${order.referralCode ?? '-'}'),
            _infoRow(theme, Icons.stars, 'Referral Bonus: ${order.referralBonusCoins} coins'),
          ],
        ),
      ),
      // _animatedCard(
      //   _section(
      //     context,
      //     title: 'Stripe Metadata',
      //     children: [
      //       _infoRow(theme, Icons.confirmation_number_outlined, 'Order Number: ${order.stripeMetadata?["order_number"] ?? '-'}'),
      //       _infoRow(theme, Icons.receipt_long, 'Stripe Order ID: ${order.stripeMetadata?["order_id"] ?? '-'}'),
      //       _infoRow(theme, Icons.person_outline, 'Stripe Customer ID: ${order.stripeMetadata?["customer_id"] ?? '-'}'),
      //     ],
      //   ),
      // ),

      _animatedCard(
        _section(
          context,
          title: 'Order Meta',
          children: [
            _infoRow(theme, Icons.home_work, 'Customer Addr ID: ${order.customerAddressId}'),
            _infoRow(theme, Icons.schedule, 'Schedule ID: ${order.scheduledTimeId}'),
          ],
        ),
      ),
    _animatedCard(
    _section(
    context,
    title: 'System Metadata',
    children: [
    // _infoRow(theme, Icons.fingerprint, 'Encrypted ID: ${order.encryptedId}'),
    if (order.createdAt != null)
    _infoRow(theme, Icons.schedule, 'Created: ${DateFormat.yMMMd().add_jm().format(order.createdAt!)}'),
    if (order.updatedAt != null)
    _infoRow(theme, Icons.update, 'Updated: ${DateFormat.yMMMd().add_jm().format(order.updatedAt!)}'),
    if ((order.deletedAt ?? '').isNotEmpty)
    _infoRow(theme, Icons.delete_forever, 'Deleted At: ${order.deletedAt}'),
    ],
    ),
    ),






    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text('Order #${order.orderNumber}', style: theme.textTheme.headlineSmall),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, idx) => sections[idx],
      ),
    );
  }

  Widget _animatedCard(Widget child) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (_, value, widget) => Transform.scale(scale: value, child: widget),
      child: child,
    );
  }

  Widget _section(
      BuildContext context, {
        required String title,
        required List<Widget> children,
      }) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.primaryColor.withOpacity(0.5), width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(title,
                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.secondary)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(ThemeData theme, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.secondary),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
      ]),
    );
  }

  void _showPaymentDetailsBottomSheet(
      BuildContext context, Map<String, dynamic> d) {
    final theme = Theme.of(context);
    final simple = <String, String>{
      'Payment ID': d['id']?.toString() ?? '-',
      'Status': d['status']?.toString() ?? '-',
      'Amount': d['amount_received'] != null
          ? 'AED ${(d['amount_received'] as num).toStringAsFixed(2)}'
          : '-',
      'Currency': d['currency']?.toString().toUpperCase() ?? '-',
      'Method': (d['payment_method_types'] as List<dynamic>?)
          ?.join(', ')
          .toUpperCase() ??
          '-',
      'Created': d['created'] != null
          ? DateFormat.yMMMd()
          .add_jm()
          .format(DateTime.fromMillisecondsSinceEpoch((d['created'] as int) * 1000))
          : '-',
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.dialogBackgroundColor.withOpacity(0.95),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Payment Details', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          ...simple.entries.map((e) => ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(e.key, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text(e.value, style: theme.textTheme.bodyMedium),
          )),
          Divider(color: theme.dividerColor),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _showRawJsonDialog(context, d);
            },
            icon: Icon(Icons.code, size: 18, color: theme.colorScheme.secondary),
            label: Text('View full JSON',
                style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.secondary)),
          ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  void _showRawJsonDialog(BuildContext context, Map<String, dynamic> details) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: theme.dialogBackgroundColor,
        title: Text('Full Payment JSON', style: theme.textTheme.titleMedium),
        content: SingleChildScrollView(
          child: Text(
            const JsonEncoder.withIndent('  ').convert(details),
            style: theme.textTheme.bodyMedium?.copyWith(fontFamily: 'Courier', fontSize: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: theme.textTheme.labelLarge),
          )
        ],
      ),
    );
  }
}
