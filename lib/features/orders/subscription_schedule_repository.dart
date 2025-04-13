// import '../../../core/api_service.dart';
// import 'models/employee_model.dart';
// import 'models/subscription_schedule_model.dart';
// // import '../models/subscription_schedule_model.dart';
// // import '../models/employee_model.dart';
//
// class SubscriptionScheduleRepository {
//   final ApiService apiService;
//
//   SubscriptionScheduleRepository({required this.apiService});
//
//   Future<List<SubscriptionSchedule>> fetchDailySchedules(String date) async {
//     final response = await apiService
//         .get('/api/admin/subscription-schedules/daily?date=$date');
//     if (response.data['success'] == true) {
//       final List schedules = response.data['data']['schedules'];
//       return schedules
//           .map((json) => SubscriptionSchedule.fromJson(json))
//           .toList();
//     } else {
//       throw Exception('Failed to load subscription schedules');
//     }
//   }
//
//   Future<List<Employee>> fetchEmployeeList() async {
//     final response = await apiService.get('/api/admin/orders/list');
//     if (response.data['success'] == true) {
//       final List data = response.data['data'];
//       return data.map((e) => Employee.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load employee list');
//     }
//   }
//
//   Future<List<AssignedEmployee>> fetchAssignedEmployees(
//       int scheduleId, String date) async {
//     final response = await apiService.get(
//         '/api/admin/subscription-schedules/assigned-employees/$scheduleId/$date');
//     if (response.data['success'] == true) {
//       final List assignments = response.data['data']['assignments'];
//       return assignments.map((e) => AssignedEmployee.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to fetch assigned employees');
//     }
//   }
//
//   Future<void> assignEmployee({
//     required int scheduleId,
//     required int employeeId,
//     required String workDate,
//     required String dayOfWeek,
//   }) async {
//     final response = await apiService.postFormData(
//       '/api/admin/subscription-schedules/assign-employee',
//       {
//         'schedule_id': scheduleId,
//         'employee_id': employeeId,
//         'work_date': workDate,
//         'day_of_week': dayOfWeek,
//       },
//     );
//     if (response.data['success'] != true) {
//       throw Exception('Failed to assign employee');
//     }
//   }
//
//   Future<void> removeAssignedEmployee(int assignmentId) async {
//     final response = await apiService.postFormData(
//       '/api/admin/subscription-schedules/remove-assignment/$assignmentId',
//       {},
//     );
//     if (response.data['success'] != true) {
//       throw Exception('Failed to remove employee');
//     }
//   }
// }

import '../../../core/api_service.dart';
import 'models/employee_model.dart';
import 'models/subscription_schedule_model.dart';
// import '../models/subscription_schedule_model.dart';
// import '../models/employee_model.dart';

class SubscriptionScheduleRepository {
  final ApiService api;

  SubscriptionScheduleRepository({required this.api});

  // Future<List<SubscriptionSchedule>> getSchedules(String date) async {
  //   final res =
  //       await api.get('/api/admin/subscription-schedules/daily?date=$date');
  //   // final data = res.data['data']['schedules'] as List;
  //   final data = res.data['data']['schedules'] as List;
  //
  //   return data.map((e) => SubscriptionSchedule.fromJson(e)).toList();
  // }
  Future<List<SubscriptionSchedule>> getSchedules(String date) async {
    final res =
        await api.get('/api/admin/subscription-schedules/daily?date=$date');

    // // Make sure you're using `.data`
    // final responseData = res.data;
    //
    // final schedules = responseData['data']['schedules'];
    final responseData = res.data;
    final schedules = responseData['data']['schedules']; // ✅ Now a List

    print("Fetched schedules: ${schedules.runtimeType} | $schedules");

    if (schedules is List) {
      return schedules.map((e) => SubscriptionSchedule.fromJson(e)).toList();
    } else {
      throw Exception(
          "Expected a list for schedules but got ${schedules.runtimeType}");
    }
  }

  Future<List<Employee>> getEmployees() async {
    final res = await api.get('/api/admin/orders/list');
    final data = res.data['data'] as List;
    return data.map((e) => Employee.fromJson(e)).toList();
  }

  Future<void> assignEmployee({
    required int scheduleId,
    required int employeeId,
    required String date,
    required String day,
  }) async {
    // await api
    // .postFormData('/api/admin/subscription-schedules/assign-employee',
    final response = await api
        .postJson('/api/admin/subscription-schedules/assign-employee', {
      'schedule_id': scheduleId,
      'employee_id': employeeId,
      'work_date': date,
      'day_of_week': day,
    });
    if (response['success'] != true) {
      throw Exception('Failed to assign employee: ${response['message']}');
    }
  }

  Future<void> removeAssignment(int assignmentId) async {
    await api.get(
        '/api/admin/subscription-schedules/remove-assignment/$assignmentId');
  }

  Future<List<AssignedEmployee>> getAssignedEmployees(
      int scheduleId, String date) async {
    final res = await api.get(
        '/api/admin/subscription-schedules/assigned-employees/$scheduleId/$date');
    final data = res.data['data']['assignments'] as List;
    return data.map((e) => AssignedEmployee.fromJson(e)).toList();
  }
}
