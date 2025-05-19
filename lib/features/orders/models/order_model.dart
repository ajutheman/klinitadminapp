import 'dart:convert';

import 'package:intl/intl.dart';

class Order {
  final int id;
  final String orderNumber;
  final double total;
  final String orderStatus;
  final String paymentMethod;
  final String paymentStatus;
  final DateTime? createdAt;
  final int? customerId;
  final String? couponCode;
  final double couponDiscount;
  final String? referralCode;
  final int referralBonusCoins;
  final int? customerAddressId;
  final int scheduledTimeId;
  final int? bedrooms;
  final bool petsPresent;
  final int? beds;
  final int? sofaBeds;
  final bool withLinen;
  final bool withSupplies;
  // final String? checkInTime;
  // final String? checkOutTime;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  final int? occupancy;
  final String? doorAccessCode;
  final DateTime? bookingDate;
  final double subtotal;
  final double taxRate;
  final double taxAmount;
  // final double total;
  // final String paymentMethod;
  // final String paymentStatus;
  // final String orderStatus;
  final String? refundStatus;
  final double? refundAmount;
  final String? cancellationReason;
  final String assignStatus;
  final bool hasSubscription;
  final int subscriptionDuration;
  final String? notes;
  final String? failedReason;
  final String stripePaymentIntentId;
  final String stripePaymentId;
  final Map<String, dynamic>? paymentDetails;
  // final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String encryptedId;

  final Customer? customer;
  final Address? address;
  final List<OrderItem> orderItems;

  final List<WorkAssignment> workAssignments;

  Order({
    required this.id,
    required this.orderNumber,
    this.customerId,
    this.couponCode,
    required this.couponDiscount,
    this.referralCode,
    required this.referralBonusCoins,
    this.customerAddressId,
    required this.scheduledTimeId,
    this.bedrooms,
    required this.petsPresent,
    this.beds,
    this.sofaBeds,
    required this.withLinen,
    required this.withSupplies,
    this.checkInTime,
    this.checkOutTime,
    this.occupancy,
    this.doorAccessCode,
    this.bookingDate,
    required this.subtotal,
    required this.taxRate,
    required this.taxAmount,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    this.refundStatus,
    this.refundAmount,
    this.cancellationReason,
    required this.assignStatus,
    required this.hasSubscription,
    required this.subscriptionDuration,
    this.notes,
    this.failedReason,
    required this.stripePaymentIntentId,
    required this.stripePaymentId,
    this.paymentDetails,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.encryptedId,

    // required this.total,
    // required this.orderStatus,
    // required this.paymentMethod,
    // required this.paymentStatus,
    // required this.createdAt,
    this.customer,
    this.address,
    required this.orderItems,
    required this.workAssignments,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    DateTime? parseTime(String? ts) {
      if (ts == null) return null;
      // Normalize semicolons, if any:
      final clean = ts.replaceAll(';', ':');
      try {
        // This will create a DateTime on 1970-01-01 at that time:
        return DateFormat('HH:mm').parse(clean);
      } catch (_) {
        return null;
      }
    }
    return Order(
      id: json['id'],
      orderNumber: json['order_number'] ?? '',
      customerId: json['customer_id'],
      couponCode: json['coupon_code'],
      couponDiscount: double.tryParse(json['coupon_discount'] ?? '0') ?? 0,
      referralCode: json['referral_code'],
      referralBonusCoins: json['referral_bonus_coins'] ?? 0,
      customerAddressId: json['customer_address_id'],
      scheduledTimeId: json['scheduled_time_id'] ?? 0,
      bedrooms: json['bedrooms'],
      petsPresent: (json['pets_present'] as int?) == 1,
      beds: json['beds'],
      sofaBeds: json['sofa_beds'],
      withLinen: (json['with_linen'] as int?) == 1,
      withSupplies: (json['with_supplies'] as int?) == 1,
      // checkInTime: json['check_in_time'],
      // checkOutTime: json['check_out_time'],
      // checkInTime: json['check_in_time'] != null
      //     ? DateTime.parse(json['check_in_time'] as String)
      //     : null,
      // checkOutTime: json['check_out_time'] != null
      //     ? DateTime.parse(json['check_out_time'] as String)
      //     : null,
      checkInTime: parseTime(json['check_in_time'] as String?),
      checkOutTime: parseTime(json['check_out_time'] as String?),
      occupancy: json['occupancy'],
      doorAccessCode: json['door_access_code'],
      bookingDate: json['booking_date'] != null
          ? DateTime.tryParse(json['booking_date'])
          : null,
      subtotal: (json['subtotal'] as num).toDouble(),
      taxRate: (json['tax_rate'] as num).toDouble(),
      taxAmount: (json['tax_amount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      orderStatus: json['order_status'] ?? '',
      refundStatus: json['refund_status'],
      refundAmount: json['refund_amount'] != null
          ? (json['refund_amount'] as num).toDouble()
          : null,
      cancellationReason: json['cancellation_reason'],
      assignStatus: json['assign_status'] ?? 'no',
      hasSubscription: json['has_subscription'] as bool? ?? false,
      subscriptionDuration: json['subscription_duration'] ?? 0,
      notes: json['notes'],
      failedReason: json['failed_reason'],
      stripePaymentIntentId: json['stripe_payment_intent_id'] ?? '',
      stripePaymentId: json['stripe_payment_id'] ?? '',
      paymentDetails: json['payment_details'] != null
          ? jsonDecode(json['payment_details'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'],
      encryptedId: json['encrypted_id'] ?? '',
      // total: (json['total'] as num).toDouble(),
      // orderStatus: json['order_status'] ?? '',
      // paymentMethod: json['payment_method'] ?? '',
      // paymentStatus: json['payment_status'] ?? '',
      // createdAt: json['created_at'] != null
      //     ? DateTime.tryParse(json['created_at'])
      //     : null,
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

//
class WorkAssignment {
  final int id;
  final int orderId;
  final int employeeId;
  final String workStatus;
  final Employee employee;final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String encryptedId;

  WorkAssignment({
    required this.id,
    required this.orderId,
    required this.employeeId,
    required this.workStatus,
    required this.employee,this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    required this.encryptedId,
  });

  factory WorkAssignment.fromJson(Map<String, dynamic> json) {
    DateTime? parseNullable(String? s) =>
        s != null ? DateTime.tryParse(s) : null;

    return WorkAssignment(
      id: json['id'],
      orderId: json['order_id'],
      employeeId: json['employee_id'],
      workStatus: json['work_status'] ?? '',
      startTime: parseNullable(json['start_time'] as String?),
      endTime: parseNullable(json['end_time'] as String?),
      createdAt: parseNullable(json['created_at'] as String?),
      updatedAt: parseNullable(json['updated_at'] as String?),
      encryptedId: json['encrypted_id'] as String? ?? '',
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
