// import '../../../core/services/api_service.dart';
// import '../models/order.dart';

import '../../core/api_service.dart';
import 'models/order_model.dart';

class OrderRepository {
  final ApiService apiService;

  OrderRepository({required this.apiService});

  Future<List<Order>> fetchOrders({int page = 1}) async {
    final response = await apiService.get('/api/admin/orders?page=$page');
    final List<dynamic> orderJson = response.data['data']['data'];
    return orderJson.map((json) => Order.fromJson(json)).toList();
  }
}
