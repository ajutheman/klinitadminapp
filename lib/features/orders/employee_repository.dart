import '../../../core/api_service.dart';
// import 'employee_model.dart';
import 'models/employee_model.dart';

class EmployeeRepository {
  final ApiService api;

  EmployeeRepository({required this.api});

  Future<List<Employee>> fetchEmployees() async {
    final response = await api.get('/api/admin/orders/list');
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => Employee.fromJson(e)).toList();
  }

  Future<void> assignEmployees(int orderId, List<int> employeeIds) async {
    await api.dio.post('/api/admin/orders/assignments', data: {
      'order_id': orderId,
      'employee_ids': employeeIds,
    });
  }
}
