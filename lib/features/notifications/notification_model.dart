class OrderLite {
  final int id;
  final String orderNumber;
  final num? total;
  final String? orderStatus;
  final String? paymentStatus;
  final String? bookingDate;

  // NEW:
  final bool hasSubscription;

  const OrderLite({
    required this.id,
    required this.orderNumber,
    this.total,
    this.orderStatus,
    this.paymentStatus,
    this.bookingDate,
    this.hasSubscription = false, // default false
  });

  factory OrderLite.fromJson(Map<String, dynamic> json) {
    final rawHasSub = json['has_subscription'];
    final hasSub = rawHasSub == true ||
        rawHasSub == 1 ||
        rawHasSub?.toString().toLowerCase() == 'true';

    return OrderLite(
      id: json['id'] as int,
      orderNumber: json['order_number']?.toString() ?? '',
      total: json['total'] is num ? json['total'] as num : num.tryParse(json['total']?.toString() ?? ''),
      orderStatus: json['order_status']?.toString(),
      paymentStatus: json['payment_status']?.toString(),
      bookingDate: json['booking_date']?.toString(),
      hasSubscription: hasSub, // <-- set it
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
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as int,
      userId: json['user_id'] as int?,
      orderId: json['order_id'] as int?,
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      data: json['data']?.toString(),
      isRead: (json['is_read'] == true) || (json['is_read']?.toString() == '1'),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '')?.toUtc() ?? DateTime.now().toUtc(),
      order: json['order'] is Map<String, dynamic> ? OrderLite.fromJson(json['order'] as Map<String, dynamic>) : null,
    );
  }
}
