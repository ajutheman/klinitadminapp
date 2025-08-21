import '../../core/api_service.dart';
import 'notification_model.dart';

class NotificationRepository {
  final ApiService apiService;
  NotificationRepository({required this.apiService});

  Future<List<AppNotification>> fetchNotifications() async {
    const url = '/api/admin/notification/list';
    // Debug prints
    // ignore: avoid_print
    print("📤 GET $url");

    final response = await apiService.get(url);

    // ignore: avoid_print
    print("📦 API Response: ${response.data}");

    final list = (response.data?['data'] as List<dynamic>? ?? []);
    return list.map((e) => AppNotification.fromJson(e as Map<String, dynamic>)).toList();
  }
}
