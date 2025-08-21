class OrderLite {
  final int id;
  final String orderNumber;
  final num? total;
  final String? orderStatus;
  final String? paymentStatus;
  final String? bookingDate;

  // NEW (all optional -> won’t break other code)
  final bool hasSubscription;
  final int? subscriptionDuration;
  final String? paymentMethod;
  final String? typeOfCleaning;

  const OrderLite({
    required this.id,
    required this.orderNumber,
    this.total,
    this.orderStatus,
    this.paymentStatus,
    this.bookingDate,
    this.hasSubscription = false, // default false
    this.subscriptionDuration,
    this.paymentMethod,
    this.typeOfCleaning,
  });

  factory OrderLite.fromJson(Map<String, dynamic> json) {
    final rawHasSub = json['has_subscription'];
    final hasSub = rawHasSub == true ||
        rawHasSub == 1 ||
        rawHasSub?.toString().toLowerCase() == 'true';

    num? _toNum(dynamic v) =>
        v is num ? v : num.tryParse(v?.toString() ?? '');

    int? _toInt(dynamic v) =>
        v is int ? v : int.tryParse(v?.toString() ?? '');

    return OrderLite(
      id: (json['id'] is int)
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      orderNumber: json['order_number']?.toString() ?? '',
      total: _toNum(json['total']),
      orderStatus: json['order_status']?.toString(),
      paymentStatus: json['payment_status']?.toString(),
      bookingDate: json['booking_date']?.toString(),
      hasSubscription: hasSub,
      subscriptionDuration: _toInt(json['subscription_duration']),
      paymentMethod: json['payment_method']?.toString(),
      typeOfCleaning: json['type_of_cleaning']?.toString(),
    );
  }
}

class AppNotification {
  final int id;
  final int? userId;
  final int? orderId;
  final String title;
  final String body;
  final String? data;
  bool isRead;
  final DateTime createdAt;
  final OrderLite? order;

  // NEW (optional)
  final String? type;

  AppNotification({
    required this.id,
    this.userId,
    this.orderId,
    required this.title,
    required this.body,
    this.data,
    required this.isRead,
    required this.createdAt,
    this.order,
    this.type,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: (json['id'] is int)
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: json['user_id'] is int ? json['user_id'] as int : int.tryParse(json['user_id']?.toString() ?? ''),
      orderId: json['order_id'] is int ? json['order_id'] as int : int.tryParse(json['order_id']?.toString() ?? ''),
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      data: json['data']?.toString(),
      type: json['type']?.toString(),
      isRead: (json['is_read'] == true) || (json['is_read']?.toString() == '1'),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '')?.toUtc() ?? DateTime.now().toUtc(),
      order: json['order'] is Map<String, dynamic>
          ? OrderLite.fromJson(json['order'] as Map<String, dynamic>)
          : null,
    );
  }
}

// Helper to parse the API envelope you posted
List<AppNotification> parseNotificationsResponse(Map<String, dynamic> json) {
  final list = json['data'] as List? ?? const [];
  return list
      .whereType<Map<String, dynamic>>()
      .map(AppNotification.fromJson)
      .toList();
}
