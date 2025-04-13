// import '../../../core/services/api_service.dart';
// import '../models/login_response.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api_service.dart';
import '../login_response.dart';

class AuthRepository {
  final ApiService api;

  AuthRepository(this.api);

  Future<LoginResponse> login(String email, String password) async {
    final response = await api.postFormData('/api/admin/login', {
      'email': email,
      'password': password,
    });
    return LoginResponse.fromJson(response.data);
  }

  Future<void> registerFcmToken(String fcmToken) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('admin_token');

    await api.postJson(
      '/api/admin/admin-notification/fcm/register-token',
      {'fcm_token': fcmToken},
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}
