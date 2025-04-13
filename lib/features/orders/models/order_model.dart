class Order {
  final int id;
  final String orderNumber;
  final double total;
  final String orderStatus;
  final String paymentMethod;
  final String paymentStatus;
  final DateTime? createdAt;

  final Customer? customer;
  final Address? address;
  final List<OrderItem> orderItems;

  final List<WorkAssignment> workAssignments;

  Order({
    required this.id,
    required this.orderNumber,
    required this.total,
    required this.orderStatus,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    this.customer,
    this.address,
    required this.orderItems,
    required this.workAssignments,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'] ?? '',
      total: (json['total'] as num).toDouble(),
      orderStatus: json['order_status'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      orderItems: (json['order_items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e))
              .toList() ??
          [],
      workAssignments: (json['work_assignments'] as List<dynamic>?)
              ?.map((e) => WorkAssignment.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class WorkAssignment {
  final int id;
  final int orderId;
  final int employeeId;
  final String workStatus;
  final Employee employee;

  WorkAssignment({
    required this.id,
    required this.orderId,
    required this.employeeId,
    required this.workStatus,
    required this.employee,
  });

  factory WorkAssignment.fromJson(Map<String, dynamic> json) {
    return WorkAssignment(
      id: json['id'],
      orderId: json['order_id'],
      employeeId: json['employee_id'],
      workStatus: json['work_status'] ?? '',
      employee: Employee.fromJson(json['employee']),
    );
  }
}

class Employee {
  final int id;
  final String name;
  final String image;

  Employee({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class Customer {
  final int id;
  final String name;
  final String email;
  final String mobile;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }
}

class Address {
  final int id;
  final String buildingName;
  final String area;

  Address({
    required this.id,
    required this.buildingName,
    required this.area,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      buildingName: json['building_name'] ?? '',
      area: json['area'] ?? '',
    );
  }
}

class OrderItem {
  final int id;
  final int orderId;
  final int employeeCount;
  final String type;
  final int? subscriptionFrequency;
  final double itemTotal;
  final ThirdCategory? thirdCategory;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.employeeCount,
    required this.type,
    this.subscriptionFrequency,
    required this.itemTotal,
    this.thirdCategory,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      employeeCount: json['employee_count'] ?? 1,
      type: json['type'] ?? '',
      subscriptionFrequency: json['subscription_frequency'],
      itemTotal: (json['item_total'] as num).toDouble(),
      thirdCategory: json['third_category'] != null
          ? ThirdCategory.fromJson(json['third_category'])
          : null,
    );
  }
}

class ThirdCategory {
  final int id;
  final String name;
  final String image;

  ThirdCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ThirdCategory.fromJson(Map<String, dynamic> json) {
    return ThirdCategory(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
