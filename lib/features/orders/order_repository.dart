// // import '../../../core/services/api_service.dart';
// // import '../models/order.dart';
//
// import '../../core/api_service.dart';
// import 'models/order_model.dart';
//
// class OrderRepository {
//   final ApiService apiService;
//
//   OrderRepository({required this.apiService});
//
//   Future<List<Order>> fetchOrders({int page = 1}) async {
//     final response = await apiService.get('/api/admin/orders?page=$page');
//     final List<dynamic> orderJson = response.data['data']['data'];
//     return orderJson.map((json) => Order.fromJson(json)).toList();
//   }
// }
import 'package:intl/intl.dart';
// import '../core/api_service.dart';
import '../../core/api_service.dart';
import 'models/order_model.dart';

class OrderRepository {
final ApiService apiService;

OrderRepository({ required this.apiService });

/// Fetch orders for a specific date (yyyy-MM-dd) and page.
Future<List<Order>> fetchOrders({
required DateTime date,
int page = 1,
}) async {
final dateString = DateFormat('yyyy-MM-dd').format(date);
final response = await apiService.get(
'/api/admin/orders?date=$dateString&page=$page',
);
final data = response.data['data']['data'] as List<dynamic>;
return data.map((json) => Order.fromJson(json)).toList();
}
}
