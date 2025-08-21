// import 'package:flutter/material.dart';
// import '../models/order_model.dart';
// import '../order_repository.dart'; // wherever your repo is
// import '../../core/api_service.dart';
// import '../orders/models/order_model.dart';
// import '../orders/order_repository.dart';
// import '../orders/screens/OrderDetailPage.dart';
// import 'order_detail_page.dart';   // your file from the message
//
// class OrderDetailLoaderPage extends StatefulWidget {
//   final int orderId;
//   const OrderDetailLoaderPage({super.key, required this.orderId});
//
//   @override
//   State<OrderDetailLoaderPage> createState() => _OrderDetailLoaderPageState();
// }
//
// class _OrderDetailLoaderPageState extends State<OrderDetailLoaderPage> {
//   late final OrderRepository _repo;
//   Order? _order;
//   String? _error;
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _repo = OrderRepository(apiService: ApiService());
//     _fetch();
//   }
//
//   Future<void> _fetch() async {
//     try {
//       final order = await _repo.fetchOrderById(widget.orderId);
//       setState(() => _order = order);
//     } catch (e) {
//       setState(() => _error = e.toString());
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Order #${widget.orderId}')),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }
//     if (_error != null) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Order #${widget.orderId}')),
//         body: Center(child: Text('Error: $_error')),
//       );
//     }
//     return OrderDetailPage(order: _order!);
//   }
// }
