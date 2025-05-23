class SubscriptionSchedule {
  final int scheduleId;
  final String date;
  final String dayOfWeek;
  final CustomerInfo customer;
  final OrderInfo order;
  final CategoryInfo category;
  final List<AssignedEmployee> assignedEmployees;

  SubscriptionSchedule({
    required this.scheduleId,
    required this.date,
    required this.dayOfWeek,
    required this.customer,
    required this.order,
    required this.category,
    required this.assignedEmployees,
  });

  // factory SubscriptionSchedule.fromJson(Map<String, dynamic> json) {
  //   return SubscriptionSchedule(
  //     scheduleId: json['schedule_id'] ?? 0,
  //     date: json['date'] ?? '',
  //     dayOfWeek: json['day_of_week'] ?? '',
  //     customer: CustomerInfo.fromJson(json['customer'] ?? {}),
  //     order: OrderInfo.fromJson(json['order'] ?? {}),
  //     category: CategoryInfo.fromJson(json['category'] ?? {}),
  //     assignedEmployees: (json['assigned_employees'] as List<dynamic>?)
  //             ?.map((e) => AssignedEmployee.fromJson(e))
  //             .toList() ??
  //         [],
  //   );
  // }
  factory SubscriptionSchedule.fromJson(Map<String, dynamic> json) {
    final rawAssigned = json['assigned_employees'];
    List<AssignedEmployee> assigned = [];

    if (rawAssigned is List) {
      assigned = rawAssigned.map((e) => AssignedEmployee.fromJson(e)).toList();
    } else if (rawAssigned is Map) {
      assigned =
          rawAssigned.values.map((e) => AssignedEmployee.fromJson(e)).toList();
    }

    return SubscriptionSchedule(
      scheduleId: json['schedule_id'] ?? 0,
      date: json['date'] ?? '',
      dayOfWeek: json['day_of_week'] ?? '',
      customer: CustomerInfo.fromJson(json['customer'] ?? {}),
      order: OrderInfo.fromJson(json['order'] ?? {}),
      category: CategoryInfo.fromJson(json['category'] ?? {}),
      assignedEmployees: assigned,
    );
  }
}

class OrderInfo {
  final int id;
  final double total;
  final String createdAt;
  final int employeeCount;

  OrderInfo({
    required this.id,
    required this.total,
    required this.createdAt,
    required this.employeeCount,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        id: json['id'],
        total: (json['total'] ?? 0).toDouble(),
        createdAt: json['created_at'] ?? '',
        employeeCount: json['employee_count'] ?? 0,
      );
}

class CustomerInfo {
  final String name;
  final String phone;
  final String address;

  CustomerInfo({
    required this.name,
    required this.phone,
    required this.address,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        name: json['name'] ?? 'N/A',
        phone: json['phone'] ?? 'N/A',
        address: json['address'] ?? 'N/A',
      );
}

class CategoryInfo {
  final String name;
  final String description;

  CategoryInfo({
    required this.name,
    required this.description,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        name: json['name'] ?? 'N/A',
        description: json['description'] ?? '',
      );
}

class AssignedEmployee {
  final int id;
  final String name;
  final String status;

  AssignedEmployee({
    required this.id,
    required this.name,
    required this.status,
  });

  // factory AssignedEmployee.fromJson(Map<String, dynamic> json) {
  //   final employee = json['employee'];
  //   return AssignedEmployee(
  //     id: employee?['id'] ?? 0,
  //     name: employee?['name'] ?? 'n/a',
  //     status: json['work_status'] ?? 'pending',
  //   );
  // }
  factory AssignedEmployee.fromJson(Map<String, dynamic> json) {
    final employee = json['employee'];
    return AssignedEmployee(
      id: json['id'] ?? employee?['id'] ?? 0,
      name: json['name'] ?? employee?['name'] ?? 'n/a',
      status: json['status'] ?? json['work_status'] ?? 'pending',
    );
  }
}
